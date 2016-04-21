---
layout: post
title: "Week 3: Technical Framework"
---

This week, we discussed more technical details about how our application
would work. First, we all discussed a common message format that we would
use to communicate between server and client. We also experimented with
the characteristics of the mesh data we receive from the Hololens. Finally,
Hamid and Edward went over several possible approaches for alignment and
mesh merging/refinement.

## Communications Protocol
We use Google's
[Protocol Buffers](https://developers.google.com/protocol-buffers/)
to define our communications protocol. This handles a lot of headaches that
would be involved dealing with byte streams, endianness, and consistency
between client and server code.

FIXME

## Mesh Quality Experiments
The Hololens geometry data is provided to the user as a collection of several
submeshes. This is advantageous to us because we do not have to transmit the
entire mesh any time we wish to update the server's model of the scene. This
also means that if the initial alignment between different Hololens devices
in the multiplayer setting is good, then we can deal with submeshes from
multiple devices in the same way we deal with submeshes from a single device.

{% include sketchfab_embed.html meshid="5b8de5a267ae416a85a78f75e0260d8a" %}

These submeshes do overlap in regions, so it's not simply a matter of stitching
them together or concatenating them. We will almost certainly take a volumetric
approach (a la KinectFusion) to get a global model of the mesh.

We have concerns about the mesh resolution we are able to get from the device.
After speaking to several members of the Hololens team, they admitted that there
is currently no way in the API to access lower-level data (e.g. SDFs or depth
maps). They suggested that the finest resolution mesh that the API provides
is of equivalent resolution to the depth maps (so we suspect this is just the
raw marching cubes mesh on the SDF they use for reconstruction). We also heard
rumors of some side channel or internal tool that could be used to get the raw
data, but it is unclear if we will be able to use this.

## Mesh Alignment Approaches

## Mesh Refinement Approaches
