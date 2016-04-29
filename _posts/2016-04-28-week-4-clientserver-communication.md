---
layout: post
title: "Week 4: Client-Server Communication"
---

This week, we got our basic client-server system up and running (mostly). The Hololens can successfully send meshes to our python server, using the Google protobuf libraries we discussed [last week]({% post_url 2016-04-21-week-3-technical-framework %}). The server was Keunhong's work, while Edward and Alex worked on the Unity/Hololens side of the communications.
Hamid also did some further investigation on the characteristics of the Hololens meshes to better inform server side processing.

## Server Architecture

The server accepts connections from a client asynchronously. Each connection accepts incoming Protocol Buffer messages which the server can handle accordingly.

Messages of type `MESH` are parsed into a datastructure for further processing.

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

The server also accepts updates to the client's position:

```
message LocationRequest {
    ;
}
message LocationResponse {
    Vec3D location = 1;
    Vec3D orientation = 2;
}
```



## Client Communications Architecture

Work in progress...

## Mesh Analysis

Work in progress...

## Plans
While some concrete stuff got done this week, we still don't have our basic gameplay interface. 
This will be the main task for Alex and Edward next week.
Other low-hanging fruit: letting the server send meshes back to the Hololens should be very straightforward now, it's just a matter of implementing it.
Meanwhile, Hamid and Keunhong will start implementing the mesh processing framework (and integrating it with the server) and major data structures.
