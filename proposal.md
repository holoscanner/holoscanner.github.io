---
layout: default
title: Project Proposal
---

## Abstract

_The Hololens has the capabilities to produce good quality 3D scans of indoor scenes, but spending time scanning a room can be a tedious process. In order to view objects, perform tasks, or even play games, Hololens users spend a lot of time looking around and exploring their environments, so why not design applications that encourage this exploration to occur in regions which need to be scanned?_

_We propose creating a game which, as a result of its mechanics, causes the players to inadvertently produce an accurate and complete scan of their surroundings._

## The Gameplay

Currently, we are considering a number of gameplay options. Our goal is to produce a convincing and entertaining experience that successfully obfuscates the ulterior motive of scanning the room. The following is our current draft of the gameplay, although we are open to other ideas. 

### Draft: Hide and Seek

The game state begins with the players standing in a room. As the application launches, a number of bunnies appear in the room, but quickly scurry away. 

![The start state](images/bunnies.png)

The goal becomes to find the bunnies before the other players. Players will search the explorable space for the bunnies. Spatial sound cues will be given to lead players in the general direction of bunnies. Once found, bunnies will reappear in other parts of the scene until some criteria is met. 

Behind the scenes, the placement of bunnies is selected based on regions of the room which require additional scanning. By placing bunnies near regions that need scanning, players will likely move their gaze through that region, providing additional observations to refine the 3D model.  

## The Scanning

The primary objective in this application is producing a high-quality 3D mesh which accurately models the scene around the players. Doing this involves identifying regions that need to be scanned. These regions can be regions that haven't yet been scanned by any of the players, or even regions with inconsistent models across multiple Hololens devices. Once these regions are identified, the gameplay will cue users to move towards that region to provide additional observations.

A missing region:
![A missing region](images/missing.png)

A region with inconsistent models across Hololens devices:
![An inconsistent region](images/inconsistent.png)
![A magnified version of the same image](images/inconsistent_zoom.png)


## Technical Challenges

### Multiplayer

**Mesh Alignment**:
Alignment of the global model across multiple devices may prove to be a challenge if there are few overlapping regions or the individual models are noisy and inconsistent. It may be necessary to provide some user input to generate an initial rough alignment. 

**Model Consistency**:
It's important that throughout the game, players all experience the same 3D scene. This involves not only aligning multiple models, but merging the observations into a globally optimal model that is as consistent as possible with the input data from each player's Hololens. This is necessary because the gameplay involves objects hiding behind scanned occluders in the scene, and therefore all players must have a consistent occlusions. 

### Mesh Region Scoring

In order to decide whether a region needs to be scanned, it's necessary to determine the quality of the current scan. If individual models are inconsistent, the alignment error can be used, and if the region has no data whatsoever, it should certainly be scanned. There are however several edge cases: 

**Scene Complexity and Unscannable Regions**:
There also exist cases in which a region cannot be scanned, or is too complex to be scanned accurately. A mirror, for example, may be seen hundreds of times from different perspectives, but may never produce a consistent model of its true geometry. Therefore, it may be necessary to identify the number of observations that have been given for a particular region and if a consistent model has not been generated, either forego reconstruction of that region or produce an estimate given its surroundings.

### Termination Criteria
Deciding whether a mesh is "good enough" is non-trivial. This will involve deciding on some quality metric for the mesh. 

### Object Placement
If we decide to implement any variant of the hide-and-seek game above, we will be often be placing objects near parts of the mesh that are incomplete. This may prove to be a problem, considering that missing parts of the model may occupy large portions of the free space in which we might consider placing the hidden object. Some analysis must be done to avoid placing our hidden objects within real-world geometry. 

## Questions and Concerns
Will there be portions of the mesh corresponding to the other players in the room even if those players are moving?

Can we get any more low-level data from the Hololens? SDF, depth map?

How well can we approximate the mesh with primitives and still have a compelling experience?


