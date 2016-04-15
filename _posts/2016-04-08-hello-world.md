---
layout: post
title: "Hello, World!"
---

Welcome to the Holoscanner blog! Here, we'll post regular updates on the
development of our Hololens app. This project is part of the first ever
[AR/VR Capstone](http://courses.cs.washington.edu/courses/cse481v/16sp/home.php)
at the University of Washington, where teams of four students get access to
multiple Hololens devices to make a holographic app in a single 10-week quarter.

### The Story ###
Our team of PhD students is in the interesting position of having the
deep technical knowledge, early access to the Hololens hardware, and
direct collaboration with the Hololens team at Microsoft.
We wanted to work on an application that had interesting,
research-like challenges that we were uniquely qualified to solve, rather
than just another AR game that any developer with a Hololens could implement.

Several of us do research related to room-scale 3D scanning and reconstruction, and
we commonly encounter problems with incomplete or inaccurate scans. Getting good scans
is an art. The sophisticated tracking and reconstruction capabilities
of the Hololens make it a promising scanning device, and its user interface
opens up an interesting questions: if everyone has a Hololens, can everyone
get expert-quality 3D scans? Holoscanner is our first stab at enabling this
vision.

{% include youtube_embed.html video="s_JvpplcfzU" %}

### The Plan ###
Our app will have two main parts: the frontend running on the Hololens, with an
engaging game, and the backend running in the cloud, which will refine the
scans and analyze them to determine what regions need further scanning.

The game will be based around the mechanic of locating objectives in the scene,
which will be hidden in the regions that need more scanning. We start with the barebones
treasure-hunting interpretation of this mechanic, but might extend it if time permits.

The backend involves the two interesting research problems of mesh refinement and region-quality
evaluation. Combining the 3D data from multiple devices and scans is a fairly well-studied problem,
but tweaking existing methods for the unique demands of augmented reality applications might be
challenging, especially when combined with latency and bandwidth concerns. Meanwhile, identifying
inconsistent, incomplete, or difficult-to-scan regions is a fairly novel problem and will be
very interesting to investigate.

More details can be found in the [Proposal](/proposal) and [Project Requirements Document](/prd).

---

Edward Zhang
