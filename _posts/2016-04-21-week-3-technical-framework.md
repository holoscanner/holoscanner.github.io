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

Our protocol defines a generic message passing format as well as a specific mesh format.
The mesh format is similar to others--it defines vertices then faces which use these
vertices.

```
syntax = "proto3";

message Vec3D {
    float x = 1;
    float y = 2;
    float z = 3;
}

message Vec4D {
    float x = 1;
    float y = 2;
    float z = 3;
    float w = 4;
}

message Face {
    uint32 v1 = 1;
    uint32 v2 = 2;
    uint32 v3 = 3;
}

message Mesh {
    uint32 mesh_id = 2;
    uint64 timestamp = 3;

    // We need the camera position in case we want to do space carving.
    Vec3D cam_position = 100;
    Vec4D cam_rotation = 101;

    repeated Vec3D vertices = 200;
    repeated Face faces = 201;
}

message LocationRequest {
    ;
}
message LocationResponse {
    Vec3D location = 1;
    Vec3D orientation = 2;
}

message Message {
    enum Type {
        MESH = 0;
        LOCATION_REQUEST = 1;
        LOCATION_RESPONSE = 2;
    }

    Type type = 1;
    uint32 device_id = 2;

    // One of the following will be filled in.
    Mesh mesh = 100;
    LocationRequest location_request = 300;
    LocationResponse location_response = 400;
}
```


## Server-Client Architecture

Our project will have a client and server component. The client (Hololens) will pass relevant information to the server for heavy processing (mesh alignment, refinement etc.).


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

## Mesh Processing

We anticipate that most of our mesh processing approaches will be based on volumetric integration methods,
based on the methods introduced by [VRIP](https://graphics.stanford.edu/papers/volrange/) (Curless & Levoy 1996)
and refined in [KinectFusion](http://research.microsoft.com/en-us/projects/surfacerecon/) (Newcombe et al. 2011).

### Mesh Alignment Approaches

For mesh alignment, we will start with the rough alignment of coordinate systems between Hololens devices provided by the HoloToolkit Sharing code.
If this proves to be insufficient, we can refine alignments relative either to a global volumetric model (similar to KinectFusion) or relative
to one of the Hololens meshes. Fine scale alignment can be done by using ICP.

Larger scale misalignments (e.g. subtle warping when walls do not quite line up or bend) coulld be aligned by taking advantage of the
Manhattan World assumption of the large planes in the world. We could use an alignment method that forces large planes to be parallel
or coplanar.

### Mesh Refinement Approaches

In terms of mesh refinement, we will begin with the problem of effectively integrating multiple meshes. This will provide a single, 
clean mesh rather than the several overlapping noisy meshes in the raw input. We will also implement a
signed distance function-based approach as in VRIP and KinectFusion, which will average out the noise. We also imagine that aligning
the volume with the dominant directions of the walls will let us smooth the volume and provide even cleaner reconstructions for these
surfaces.

Another challenge is dealing with dynamic objects. In our global volume, it is possible that dynamic objects will be reconstructed as
scene geometry. However, for any new mesh captured from a particular viewpoint, we can render a depth map of the global volume and compare
it to the new mesh. If there is a surface in the global map that is closer than a surface in the new observation, then we know that the
data in the global map is in error and those voxels should be cleared. Note that this does not work for detecting dynamic objects in new
scans that are not in the global volume, since these are just as likely to be new unscanned data that should be in the scene. In this case,
we just integrate the (possibly) dynamic object into the volume, and when another device views the space again, the above algorithm should then
detect and remove the dynamic object.

This framework does not handle other refinement issues we'd like to address, such as using the color images to inform occlusion boundaries.
However we probably won't have time to address this type of issue.
