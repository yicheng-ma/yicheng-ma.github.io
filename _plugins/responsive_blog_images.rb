# frozen_string_literal: true

require "cgi"
require "digest"
require "fileutils"
require "open3"
require "pathname"
require "uri"

# Turns ordinary Markdown JPEGs into responsive images during a Jekyll build.
# Original files remain untouched and are linked as the full-resolution version.
module ResponsiveBlogImages
  DEFAULT_WIDTHS = [800, 1600, 2400].freeze
  DEFAULT_QUALITY = 92
  DEFAULT_SIZES = "(max-width: 800px) calc(100vw - 30px), 740px"
  OUTPUT_ROOT = "images/responsive"
  CACHE_ROOT = ".jekyll-cache/responsive-images"
  IMAGE_PARAGRAPH = %r{<p>\s*(<img\b[^>]*>)\s*</p>}im
  SOURCE_ATTRIBUTE = /\bsrc\s*=\s*(["'])(.*?)\1/i

  class << self
    def start_build(site)
      state_for(site).replace(used: {}, image_tool_checked: false, image_command: nil)
    end

    def transform(document, lightbox: false)
      return unless document.content&.include?("<img")

      image_index = 0
      document.content = document.content.gsub(IMAGE_PARAGRAPH) do |paragraph|
        image_tag = Regexp.last_match(1)
        source_url = image_tag[SOURCE_ATTRIBUTE, 2]
        image = prepare_image(document.site, source_url)
        next paragraph unless image

        eager = image_index.zero?
        image_index += 1
        responsive_tag = build_image_tag(image_tag, document.site, image, eager)

        if lightbox
          original_url = html_escape(image[:original_url])
          %(<p class="blog-photo-frame"><a class="blog-photo-link" href="#{original_url}" data-full-resolution target="_blank" rel="noopener">#{responsive_tag}</a></p>)
        else
          %(<p class="blog-photo-frame">#{responsive_tag}</p>)
        end
      end
    end

    def publish(site)
      state_for(site)[:used].each do |cached_path, output_relative_path|
        destination = File.join(site.dest, output_relative_path)
        FileUtils.mkdir_p(File.dirname(destination))
        FileUtils.cp(cached_path, destination)
      end
    end

    private

    def state_for(site)
      @states ||= {}
      @states[site.object_id] ||= { used: {}, image_tool_checked: false, image_command: nil }
    end

    def settings(site)
      configured = site.config.fetch("responsive_images", {})
      widths = Array(configured.fetch("widths", DEFAULT_WIDTHS)).filter_map do |width|
        Integer(width, exception: false)
      end.select(&:positive?).uniq.sort

      {
        widths: widths.empty? ? DEFAULT_WIDTHS : widths,
        quality: configured.fetch("quality", DEFAULT_QUALITY).to_i.clamp(1, 100),
        sizes: configured.fetch("sizes", DEFAULT_SIZES).to_s,
        magick: ENV.fetch("MAGICK_BIN", configured.fetch("magick", "magick").to_s)
      }
    end

    def prepare_image(site, source_url)
      source = resolve_source(site, source_url)
      return unless source && image_command(site)

      dimensions = identify(site, source[:path])
      return unless dimensions

      original_width, original_height = dimensions
      variants = variant_dimensions(site, original_width, original_height)
      digest = Digest::SHA256.file(source[:path]).hexdigest[0, 16]
      cache_version = cache_version_for(site)

      variants.each do |variant|
        filename = "#{source[:stem]}-#{variant[:width]}.jpg"
        variant[:output_relative_path] = File.join(OUTPUT_ROOT, filename)
        variant[:cache_path] = File.join(site.source, CACHE_ROOT, cache_version, digest, filename)
      end

      generate_variants(site, source[:path], variants) unless variants.all? { |variant| File.file?(variant[:cache_path]) }
      return unless variants.all? { |variant| File.file?(variant[:cache_path]) }

      variants.each do |variant|
        state_for(site)[:used][variant[:cache_path]] = variant[:output_relative_path]
        variant[:url] = site_url(site, variant[:output_relative_path])
      end

      {
        original_url: source[:url],
        original_width: original_width,
        original_height: original_height,
        variants: variants
      }
    rescue StandardError => error
      Jekyll.logger.warn "Responsive images:", "Skipped #{source_url}: #{error.message}"
      nil
    end

    def resolve_source(site, source_url)
      return if source_url.nil? || source_url.empty?

      path = source_url.split(/[?#]/, 2).first
      return if path.match?(%r{\A(?:https?:)?//}i)

      baseurl = normalized_baseurl(site)
      path = path.delete_prefix(baseurl) unless baseurl.empty?
      path = "/#{path}" unless path.start_with?("/")
      decoded_path = URI::DEFAULT_PARSER.unescape(path)
      return unless decoded_path.match?(%r{\A/images/.+\.jpe?g\z}i)

      images_root = File.expand_path("images", site.source)
      full_path = File.expand_path(decoded_path.delete_prefix("/"), site.source)
      return unless full_path.start_with?("#{images_root}#{File::SEPARATOR}") && File.file?(full_path)

      relative = Pathname.new(full_path).relative_path_from(Pathname.new(images_root)).to_s
      {
        path: full_path,
        stem: relative.sub(/\.[^.]+\z/, ""),
        url: site_url(site, File.join("images", relative))
      }
    end

    def image_command(site)
      state = state_for(site)
      return state[:image_command] if state[:image_tool_checked]

      state[:image_tool_checked] = true
      candidates = [settings(site)[:magick]]
      candidates << "convert" if settings(site)[:magick] == "magick"

      candidates.uniq.each do |candidate|
        _output, _error, process = Open3.capture3(candidate, "-version")
        if process.success?
          state[:image_command] = candidate
          return candidate
        end
      rescue Errno::ENOENT
        next
      end

      Jekyll.logger.warn "Responsive images:", "ImageMagick is unavailable; using original images."
      nil
    end

    def identify(site, source_path)
      output, error, process = Open3.capture3(
        image_command(site), source_path, "-auto-orient", "-format", "%w %h", "info:"
      )
      unless process.success?
        Jekyll.logger.warn "Responsive images:", "Could not inspect #{source_path}: #{error.strip}"
        return
      end

      width, height = output.split.map(&:to_i)
      return if width.zero? || height.zero?

      [width, height]
    end

    def variant_dimensions(site, original_width, original_height)
      target_widths = settings(site)[:widths].select { |width| width < original_width }
      target_widths << [settings(site)[:widths].last, original_width].min

      target_widths.uniq.sort.map do |width|
        {
          width: width,
          height: (original_height * width.fdiv(original_width)).round
        }
      end
    end

    def generate_variants(site, source_path, variants)
      variants.each { |variant| FileUtils.mkdir_p(File.dirname(variant[:cache_path])) }
      Jekyll.logger.info "Responsive images:", "Generating #{Pathname.new(source_path).relative_path_from(Pathname.new(site.source))}"

      config = settings(site)
      command = [
        image_command(site), source_path, "-auto-orient",
        "-sampling-factor", "4:2:0", "-interlace", "Plane", "-quality", config[:quality].to_s
      ]

      variants.each do |variant|
        command.concat([
          "(", "+clone", "-resize", "#{variant[:width]}x>",
          "-write", variant[:cache_path], "+delete", ")"
        ])
      end
      command << "null:"

      _output, error, process = Open3.capture3(*command)
      return if process.success?

      variants.each { |variant| FileUtils.rm_f(variant[:cache_path]) }
      Jekyll.logger.warn "Responsive images:", "ImageMagick failed for #{source_path}: #{error.strip}"
    end

    def build_image_tag(original_tag, site, image, eager)
      variants = image[:variants]
      fallback = variants.find { |variant| variant[:width] >= 1600 } || variants.last
      srcset = variants.map { |variant| "#{variant[:url]} #{variant[:width]}w" }.join(", ")

      tag = original_tag.dup
      tag.sub!(SOURCE_ATTRIBUTE, %(src="#{html_escape(fallback[:url])}"))
      %w[srcset sizes loading fetchpriority decoding width height style].each do |attribute|
        tag.gsub!(/\s+#{attribute}\s*=\s*(?:"[^"]*"|'[^']*'|[^\s>]+)/i, "")
      end

      if tag.match?(/\bclass\s*=\s*(["'])(.*?)\1/i)
        tag.sub!(/\bclass\s*=\s*(["'])(.*?)\1/i) do
          %(class="#{html_escape("#{Regexp.last_match(2)} blog-photo".strip)}")
        end
      else
        tag.sub!(/\s*\/?>\z/, " class=\"blog-photo\" />")
      end

      attributes = [
        %(srcset="#{html_escape(srcset)}"),
        %(sizes="#{html_escape(settings(site)[:sizes])}"),
        %(loading="#{eager ? "eager" : "lazy"}"),
        %(decoding="async"),
        %(width="#{fallback[:width]}"),
        %(height="#{fallback[:height]}"),
        %(style="width: 100%; height: auto; aspect-ratio: #{fallback[:width]} / #{fallback[:height]};")
      ]
      attributes << %(fetchpriority="high") if eager
      tag.sub!(/\s*\/?>\z/, " #{attributes.join(" ")} />")
      tag
    end

    def cache_version_for(site)
      config = settings(site)
      Digest::SHA256.hexdigest([config[:widths], config[:quality], config[:sizes]].join("|"))[0, 12]
    end

    def site_url(site, relative_path)
      "#{normalized_baseurl(site)}/#{relative_path.to_s.delete_prefix("/")}".gsub(%r{/+}, "/")
    end

    def normalized_baseurl(site)
      baseurl = site.config.fetch("baseurl", "").to_s
      return "" if baseurl.empty? || baseurl == "/"

      "/#{baseurl.gsub(%r{\A/+|/+\z}, "")}"
    end

    def html_escape(value)
      CGI.escapeHTML(value.to_s)
    end
  end
end

Jekyll::Hooks.register :site, :pre_render do |site|
  ResponsiveBlogImages.start_build(site)
end

Jekyll::Hooks.register :posts, :post_convert do |post|
  ResponsiveBlogImages.transform(post, lightbox: true)
end

Jekyll::Hooks.register :pages, :post_convert do |page|
  next unless page.data["layout"] == "home"

  ResponsiveBlogImages.transform(page, lightbox: false)
end

Jekyll::Hooks.register :site, :post_write do |site|
  ResponsiveBlogImages.publish(site)
end
