---
layout: post
title: "Week 4: Client-Server Communication"
---

This week, we got our basic client-server system up and running (mostly). The Hololens can successfully send meshes to our python server, using the Google protobuf libraries we discussed [last week]({% post_url 2016-04-21-week-3-technical-framework %}). The server was Keunhong's work, while Edward and Alex worked on the Unity/Hololens side of the communications.
Hamid also did some further investigation on the characteristics of the Hololens meshes to better inform server side processing.

## Protocol Buffer Plumbing

Keunhong and Edward, as former Google interns, were generally familiar with the usage of Protocol Buffers. The Protocol Buffer library allows developers to define a
data structure, and then generates code that allows this data to be exchanged between different programming languages. This means that any changes to the data only have
to be made in one place, rather than risking inconsistency between a client and server.

To use protocol buffers, we first define a message type in a `.proto` file. Examples of `.proto` syntax are shown below. Then, after installing the [appropriate Protobuf library for your language](https://github.com/google/protobuf), simply run the `protoc` command with the appropriate language argument. For example, we use `protoc holoscanner.proto --python_out=.`. This generates a language-specific (e.g. python) file specific to your message datatype that can then be included in your code.

## Server Architecture

### Protocol

The server accepts connections from a client asynchronously. Each connection accepts incoming Protocol Buffer messages which the server can handle accordingly.
These Protocol Buffers may be broken up into several packets, so before sending/receiving the bytes containing the protobuf we send an 8-byte unsigned long integer with the total size of the protobuf message. Messages of type `MESH` are parsed into a datastructure for further processing.

Messages are encoded in a generic Message protobuf.

```
message Message {
    enum Type {
        ACK = 0;
        MESH = 10;
        LOCATION_REQUEST = 11;
        LOCATION_RESPONSE = 12;
    }

    Type type = 1;
    uint32 device_id = 2;

    // One or less of the following will be filled in.
    Mesh mesh = 100;
    LocationRequest location_request = 300;
    LocationResponse location_response = 400;
}
```

The mesh is encoded in a wavefront or PLY-like structure with vertices and face indices.

```
message Mesh {
    uint32 mesh_id = 2;
    uint64 timestamp = 3;

    // We need the camera position in case we want to do space carving.
    Vec3D cam_position = 100;
    Vec4D cam_rotation = 101;

    repeated Vec3D vertices = 200;
    repeated Face faces = 201;
}
```

Each mesh is associated with a timestamp since we wish to know whether the mesh has been updated . The camera positions are useful for operations such as space carving.

When the client needs a new 3D location as a game objective (i.e. a place to hide an object), it makes a `LocationRequest` message, and gets back a `LocationResponse` message.

```
message LocationRequest {
    ;
}
message LocationResponse {
    Vec3D location = 1;
    Vec3D orientation = 2;
}
```

### Implementation Details

We use the standard library asyncio module to implement asynchronous communication. This allows us to handle the data without having to manage threads manually.

We performed a sanity check of the system using a custom wavefront mesh parser using a mock client. The server correctly receives and handles the message.


## Client Communications Architecture

We started with the Spatial Mapping code provided in HoloToolkit. In particular, the `RemoteMeshManager` converts all the Unity meshes into byte arrays when the user says "Send Meshes", while `RemoteMeshSource` sends byte arrays over a TCP socket. We took out the extraneous functionality from the `RemoteMeshManager` (that dealt with viewing meshes sent from the Hololens on a desktop), and wrote our own plumbing to convert Unity meshes into our protobuf format. We also removed a single line from `RemoteMeshSource`, since in the HoloToolkit implementation it sends an extra 4-byte length along with every packet (whereas we send the length before the first packet of the protobuf). We were able to successfully transfer a mesh from the Hololens to a server running on a separate machine, although the auxiliary fields (e.g. device ID, device pose) haven't yet been filled in.

## Mesh Analysis

Work in progress...

{% include sketchfab_embed.html meshid="307ae0ae0f6644c195a732c0e09febb0" %}

{% include sketchfab_embed.html meshid="1358437b4a1f44b09a409765b4fcb6e4" %}


## Plans
While some concrete stuff got done this week, we still don't have our basic gameplay interface. 
This will be the main task for Alex and Edward next week.
Other low-hanging fruit: letting the server send meshes back to the Hololens should be very straightforward now, it's just a matter of implementing it.
Meanwhile, Hamid and Keunhong will start implementing the mesh processing framework (and integrating it with the server) and major data structures.
