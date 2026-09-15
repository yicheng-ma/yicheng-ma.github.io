---
layout: scholar-home
permalink: /
title: ""
# description: "Yicheng Ma — researcher in robot learning and robotic manipulation"
description: ""
scholar_home: true
author_profile: false
header:
  show_title: false
redirect_from:
  - /about/
  - /about.html
---

<nav id="top" class="home-nav" aria-label="Primary navigation">
  <a class="home-nav__brand" href="/" aria-label="Yicheng Ma — home">YM</a>
  <div class="home-nav__links">
    <a class="home-nav__research" href="#research_interests">Research</a>
    <a href="#publications">Publications</a>
    <a href="#research_experience">Experience</a>
    <a class="home-nav__blog" href="/blog/">Blog</a>
    <a class="home-nav__contact" href="#contact">Contact <span aria-hidden="true">&#8595;</span></a>
  </div>
</nav>

<!-- ==================== PROFILE HEADER ==================== -->
<div class="profile-header">
  <div class="profile-portrait">
    <img src="images/me3.png" alt="Portrait of Yicheng Ma" width="256" height="256" />
    <!-- <span class="profile-status"><span class="status-dot" aria-hidden="true"></span>Open to PhD opportunities</span> -->
  </div>
  <div class="profile-info">
    <p class="profile-eyebrow">Robot Learning &middot; Manipulation</p>
    <h1>Yicheng Ma</h1>
    <p class="profile-subtitle">
      Research Assistant at <strong>Grasp Lab, Zhejiang University</strong>.<br>
      M.Sc. in Machine Learning at <strong>Nanyang Technological University</strong>.<br>
      <!-- Research Intern at <a href="https://www.a-star.edu.sg/simtech/research/adaptive-robotics-and-mechatronics-(arm)">A*STAR SIMTech ARM</a>, Singapore.<br> -->
      B.Eng. in Optoelectronic Information Engineering at <strong>Zhejiang University</strong>.
    </p>
    <div id="contact" class="profile-links">
      <span class="email-text">Email: yichatma [at] gmail [dot] com</span>
      <a href="https://github.com/yichatani" target="_blank" rel="noopener noreferrer"><i class="fab fa-github" aria-hidden="true"></i><span>GitHub</span><span aria-hidden="true">&#8599;</span></a>
      <a href="#publications"><span>Selected work</span><span aria-hidden="true">&#8595;</span></a>
    </div>
  </div>
</div>
<!-- ==================== BIO ==================== -->
<p class="intro-copy">
  I am currently a Research Assistant at the Grasp Lab, Zhejiang University. My research focuses on robot learning for dexterous manipulation, particularly generalizable and sample-efficient learning from limited demonstrations. I am interested in enabling robots to acquire complex manipulation skills and generalize them across objects, tasks, and environments.
</p>
<!-- My research focuses on robot learning for manipulation, with a particular interest in sample-efficient robot learning methods. Previously, I conducted research at the <a href="https://grasplab2022.github.io/">Grasp Lab</a> at Zhejiang University. I am currently exploring PhD opportunities in robot learning and manipulation and welcome inquiries via email. -->

<!-- ==================== RESEARCH INTERESTS ==================== -->
<section id="research_interests"></section>

<h2 class="section-heading">Research Interests</h2>

<!-- <div class="interest-tags">
  <span class="tag">Robot Learning</span>
  <span class="tag">Generalizable Robotic Manipulation</span>
  <span class="tag">Sample-Efficient Learning</span>
  <span class="tag">Visuomotor Policy Learning</span>
  <span class="tag">Contact-Rich Manipulation</span>
</div> -->

<div class="interest-tags">
  <span class="tag">Robot Learning</span>
  <span class="tag">Dexterous Manipulation</span>
  <span class="tag">Generalizable Manipulation</span>
  <span class="tag">Sample-Efficient Learning</span>
</div>


<!-- ==================== PUBLICATIONS ==================== -->
<section id="publications">

  <h2 class="section-heading">Publications</h2>

  <p style="font-size: 0.85em; color: var(--color-text-muted, #8c8ca1); margin-bottom: 20px;">
    (* equal contribution, &dagger; corresponding author)
  </p>

  <!-- <h3 class="pub-subheading">Published / Accepted</h3> -->
  <h3 class="pub-subheading pub-subheading-accepted">Published / Accepted</h3>

  <!-- Pub: SID -->
  <div class="pub-entry">
    <div class="pub-thumb">
      <img src="images/sid_fig1.png" alt="SID manipulation experiments" loading="lazy" decoding="async" />
    </div>
    <div class="pub-text">
      <div class="pub-title">SID: Sliding into Distribution for Robust Few-Demonstration Manipulation</div>
      <div class="pub-authors">
        <strong>Yicheng Ma*</strong>, Wei Yu*, Zhian Su, Xidan Zhang, and Huixu Dong&dagger;
      </div>
      <div class="pub-venue">
        Robotics: Science and Systems (RSS), 2026
        <span class="venue-badge oral">Oral Presentation</span>
      </div>
      <div class="pub-links">
        <a class="pub-link-button" href="https://arxiv.org/abs/2605.13428" target="_blank" rel="noopener noreferrer">Paper</a>
        <a class="pub-link-button" href="https://sliding-into-distribution.github.io/" target="_blank" rel="noopener noreferrer">Webpage</a>
      </div>
      <!-- <div class="pub-links">
        <a class="pub-link-button" href="https://sliding-into-distribution.github.io/" target="_blank" rel="noopener noreferrer">Webpage</a>
      </div> -->
      <details>
        <summary class="pub-abstract-toggle">Abstract</summary>
        <div class="pub-abstract">
          Generalizing robotic manipulation across object poses, viewpoints, and dynamic disturbances is difficult, especially with only a few demonstrations. End-to-end visuomotor policies are expressive but data-hungry, while planning and optimization satisfy explicit constraints but do not directly capture the interaction strategies demonstrated by humans. We propose Sliding into Distribution (SID), a structured framework that learns an object-centric motion field from canonicalized demonstrations to iteratively slide the system toward the demonstrated manifold and into the reliable operating region of a lightweight egocentric execution policy, mitigating out-of-distribution (OOD) execution. The motion field provides large corrective motions when far from the demonstration manifold and naturally vanishes near convergence, enabling robust reaching under substantial pose and viewpoint shifts. Within the reached regime, an egocentric policy trained with conditioned flow matching performs task-specific manipulation, supported by kinematically consistent point-cloud reprojection augmentation that preserves action–observation consistency. Across six real-world tasks, SID achieves approximately 90% success under OOD initializations with only two demonstrations, with under a 10% drop under distractors and external disturbances. Overall, SID provides a new paradigm for few-shot manipulation: explicitly managing distribution shift via online distribution recovery.
        </div>
      </details>
    </div>
  </div>


  <!-- Pub: FD-VLA -->
  <div class="pub-entry">
    <div class="pub-thumb">
      <img src="images/FDVLA.png" alt="FD-VLA method overview" loading="lazy" decoding="async" />
    </div>
    <div class="pub-text">
      <div class="pub-title">FD-VLA: Force-Distilled Vision-Language-Action Model for Contact-Rich Manipulation</div>
      <div class="pub-authors">
        Ruiteng Zhao, Wenshuo Wang, <strong>Yicheng Ma</strong>, Xiaocong Li, Francis E.H. Tay, Marcelo H. Ang Jr. and Haiyue Zhu&dagger;
      </div>
      <div class="pub-venue">
        International Conference on Robotics and Automation (ICRA), 2026
        <!-- <span class="venue-badge accepted">Accepted</span> -->
      </div>
      <div class="pub-links">
        <a class="pub-link-button" href="https://arxiv.org/abs/2602.02142" target="_blank" rel="noopener noreferrer">Paper</a>
      </div>
      <details>
        <summary class="pub-abstract-toggle">Abstract</summary>
        <div class="pub-abstract">
          Force sensing is a crucial modality for Vision-Language-Action (VLA) frameworks, as it enables fine-grained perception and dexterous manipulation in contact-rich tasks. We present Force-Distilled VLA (FD-VLA), a novel framework that integrates force awareness into contact-rich manipulation without relying on physical force sensors. The core of our approach is a Force Distillation Module (FDM), which distills force by mapping a learnable query token, conditioned on visual observations and robot states, into a predicted force token aligned with the latent representation of actual force signals. During inference, this distilled force token is injected into the pretrained VLM, enabling force-aware reasoning while preserving the integrity of its vision-language semantics. This design provides two key benefits: first, it allows practical deployment across a wide range of robots that lack expensive or fragile force-torque sensors, thereby reducing hardware cost and complexity; second, the FDM introduces an additional force-vision-state fusion prior to the VLM, which improves cross-modal alignment and enhances perception-action robustness in contact-rich scenarios. Surprisingly, our physical experiments show that the distilled force token outperforms direct sensor force measurements as well as other baselines, which highlights the effectiveness of this force-distilled VLA approach.
        </div>
      </details>
    </div>
  </div>


  <!-- Pub: Bin-picking -->
  <div class="pub-entry">
    <div class="pub-thumb">
      <img src="images/hybrid_figure.png" alt="Hybrid robotic gripper and bin-picking system" loading="lazy" decoding="async" />
    </div>
    <div class="pub-text">
      <div class="pub-title">Construction of Bin-picking System for Logistic Application: A Hybrid Robotic Gripper and Vision-based Grasp Planning</div>
      <div class="pub-authors">
        Zhian Su, <strong>Yicheng Ma</strong>, Haotian Guo, and Huixu Dong&dagger;
      </div>
      <div class="pub-venue">
        IEEE Robotics and Automation Letters (RA-L), 2025
        <!-- <span class="venue-badge accepted">Accepted</span> -->
      </div>
      <div class="pub-links">
        <a class="pub-link-button" href="https://ieeexplore.ieee.org/document/11063337" target="_blank" rel="noopener noreferrer">Paper</a>
      </div>
      <details>
        <summary class="pub-abstract-toggle">Abstract</summary>
        <div class="pub-abstract">
          An autonomous bin-picking system for grasping various cluttered packages can significantly benefit logistics by reducing manual labor and streamlining processing. We propose a bin-picking system that includes a novel multi-mode hybrid gripper combining suction and pinch, and a corresponding vision-based grasp planning strategy based on unseen object instance segmentation. The system was evaluated in simulation achieving a 71.4% success rate, compared to suction (53.9%) and Hand-E (39.3%). Real-world experiments further validated its practicality in logistics scenarios.
        </div>
      </details>
    </div>
  </div>


  <!-- Pub: 3D-LOT -->
  <div class="pub-entry">
    <div class="pub-thumb">
      <img src="images/lot_fig.png" alt="3D-LOT Policy manipulation experiments" loading="lazy" decoding="async" />
    </div>
    <div class="pub-text">
      <div class="pub-title">3D-LOT Policy: Latent Optimal Transport Flow Matching for One-Step Action Generation</div>
      <div class="pub-authors">
        <!-- <strong>Yicheng Ma*</strong>, Mohan Liu*, Chang Su, Ruiteng Zhao, Zhiping Lin, and Haiyue Zhu&dagger; -->
        <strong>Yicheng Ma</strong>
      </div>
      <div class="pub-venue">
        NTU Master's Dissertation
        <!-- <span class="venue-badge under-review">Under Review</span> -->
      </div>
      <div class="pub-links">
        <a class="pub-link-button" href="https://dr.ntu.edu.sg/entities/publication/15700b4e-2de9-468b-bc27-2f076f0fa025" target="_blank" rel="noopener noreferrer">Paper</a>
      </div>
      <details>
        <summary class="pub-abstract-toggle">Abstract</summary>
        <div class="pub-abstract">
          Real-time efficiency is critical for visuomotor policy learning, as any delay in action generation can accumulate over sequential control steps. In this work, we introduce 3D-LOT Policy, a latent prototype-guided optimal transport flow-matching framework for effective single-step action generation. Our approach encodes 3D observations into a compact latent space that preserves task-relevant spatial information and induces prototype structures to serve as anchors for policy learning. Our experiments demonstrate that 3D-LOT achieves lower latency while maintaining or even surpassing baseline performance, offering a practical solution for fast and robust visuomotor policy learning.
        </div>
      </details>
    </div>
  </div>


  <h3 class="pub-subheading pub-subheading-review">Manuscripts Under Review</h3>

  <!-- Pub: ForceForm -->
  <div class="pub-entry">
    <div class="pub-thumb">
      <img src="images/forceform.png" alt="ForceForm gripper generation results" loading="lazy" decoding="async" />
    </div>
    <div class="pub-text">
      <div class="pub-title">ForceForm: Robotic Gripper Generation via Differentiable Force Closure Optimization</div>
      <div class="pub-authors">
        Haoran Huang, Ziyi Zheng, <strong>Yicheng Ma</strong>, Zhaohui Lin,  I-Ming Chen, and Huixu Dong&dagger;
      </div>
      <div class="pub-venue">
        <!-- IEEE/ASME Transactions on Mechatronics -->
        <!-- <span class="venue-badge under-review">Under Review</span> -->
      </div>
      <details>
        <summary class="pub-abstract-toggle">Abstract</summary>
        <div class="pub-abstract">
          Reliable manipulation in industrial settings critically depends on the geometric structure of task-specific robotic grippers. However, conventional manual design is prohibitively expensive and relies heavily on human experience, while current automated methods often lack strict physical constraints, leading to unreliable grasping. To address these challenges, we propose ForceForm, the first framework to leverage differentiable force-closure optimization for adaptive gripper geometry generation, enabling the systematic synthesis of highly stable designs. First, both objects and grippers are represented using truncated signed distance functions (TSDF) to enable fully differentiable contact kinematics. Second, we devise a composite energy function via a differentiable quadratic program. This representation unifies and generalizes both normal and shear (friction) stresses, allowing the direct optimization of robust wrench-space force closure. Third, to navigate the non-convex design landscape, MALA++, an enhanced Metropolis-Adjusted Langevin Algorithm, is introduced to successfully escape local minima and promote topological diversity. Extensive experiments demonstrate that our pipeline achieves 91.6% grasp success, 84.8% stability, and 84.9% robustness across thousands of object instances, outperforming the state-of-the-art Fit2Form baseline by 6.1%, 9.0%, and 11.2%, respectively. By bridging physically grounded modeling with generative AI, ForceForm provides promising pathways for future scalable and reliable gripper design.
        </div>
      </details>
    </div>
  </div>


  <!-- Pub: Gaussian Spotlight -->
  <div class="pub-entry">
    <div class="pub-thumb">
      <img src="images/guassian_spotlight.png" alt="Gaussian Spotlight manipulation experiments" loading="lazy" decoding="async" />
    </div>
    <div class="pub-text">
      <div class="pub-title">Gaussian Spotlight: Enhancing Visuomotor Policy Learning via Latent Spatial Keypoint Embedding</div>
      <div class="pub-authors">
        Mohan Liu*, <strong>Yicheng Ma*</strong>, Chang Su, Zhiyuan Yang, Shijun Yan, Pey Yuen Tao, and Haiyue Zhu&dagger;
      </div>
      <!-- <div class="pub-venue">
        IEEE Robotics and Automation Letters (RA-L)
        <span class="venue-badge under-review">Under Review</span>
      </div> -->
      <details>
        <summary class="pub-abstract-toggle">Abstract</summary>
        <div class="pub-abstract">
          Generative visuomotor policies rely heavily on the conditioning representation to guide the synthesis of accurate and stable control sequences. Yet, standard visual encoders produce high-dimensional embeddings that often lose fine-grained spatial information while retaining substantial redundancy. To address this bottleneck, we propose Gaussian Spotlight, designed to construct a latent spatial keypoint embedding that serves as a more precise and manipulation-aware conditioning signal. Gaussian Spotlight first generates a state-conditioned anisotropic Gaussian Attention Field that selectively amplifies spatial regions critical for interaction. It then transforms these enhanced regions into implicit, latent keypoint embeddings via an attention-guided skip-layer aggregation pathway. Extensive experiments across diverse real-world manipulation tasks and simulation benchmarks demonstrate that Gaussian Spotlight consistently enhances policy performance.
        </div>
      </details>
    </div>
  </div>

  
</section>


<!-- ==================== RESEARCH EXPERIENCE ==================== -->
<section id="research_experience"></section>

<h2 class="section-heading">Research Experience</h2>


<!-- ---- Grasp Lab ---- -->
<div class="exp-block">
  <div class="exp-header">
    <span class="exp-org">Grasp Lab, Zhejiang University</span>
    <span class="exp-role">&mdash; Research Assistant</span>
    <span class="exp-date">Oct. 2025 &ndash; Present</span>
  </div>
</div>

<!-- ---- A*STAR ---- -->
<!-- <div class="exp-block" style="margin-top: 20px; padding-top: 20px; border-top: 1px solid var(--color-border-light, #f0f0f5);"> -->
<div class="exp-block">
  <div class="exp-header">
    <span class="exp-org">A*STAR SIMTech ARM, Singapore</span>
    <span class="exp-role">&mdash; Research Intern</span>
    <span class="exp-date">Sep. 2024 &ndash; Dec. 2025</span>
  </div>
</div>

<footer class="home-footer">
  <span>&copy; {{ site.time | date: '%Y' }} Yicheng Ma</span>
  <a href="#top">Back to top <span aria-hidden="true">&#8593;</span></a>
</footer>
