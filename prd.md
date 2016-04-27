---
layout: default
title: Project Requirements Document
---

## Summary

_Holoscanner is a system that creates a 3D scan of an indoor scene by processing of the depth data stream from multiple Hololens devices in a multiplayer game scenario. The primary objective in this application is producing a high-quality 3D mesh which accurately models the scene around the players. This involves alignment of the global model across multiple devices and merging the observations into a globally optimal model that is consistent with the input data from each player’s Hololens. There will be a quantitative scoring function which measures the inconsistency between the aligned mesh inputs, which determines the regions that need to be scanned as well as complex unscannable regions. Once these regions have been identified, the gameplay will cue users to move towards these areas to provide additional observations._


## Deliverables
 
- A multiplayer game application that encourages players to move around the scene, consisting of
    - A Hololens game frontend
    - A cloud mesh processing backend


- The visualization of the 3D scan of the room and showing how it improves over time

- An application scenario that uses the produced accurate 3D scan of the room


 
## Critical Features
 
- ***Mesh alignment and refinement***

   The server receives the depth data from each device and should be able to find an accurate alignment between coordinates of multiple devices.

- ***Mesh quality measure***

   The evaluation function should consider the consistency of the global reconstructed model and measure accuracy and completeness in each region of the 3D model.

- ***Gameplay Experience***

   The gameplay scenario should be interesting and encourage players to move around the game environment to capture all regions of the room from different views.

## Gameplay Description

At its core, Holoscanner is a framework for implementing hidden-objective games; any game involving the hidden-objective mechanic can use Holoscanner to get meshes and choose objective locations. Here, we describe the minimal game that we will implement, although if time permits we will try adding some more interesting elements and mechanics.

### Game Flow
When the first player opens the application, a set of characters will appear on a flat surface in front of them. Other players are given a chance to join the session, then one of the players will start the game by saying "start game". The characters will then run quickly out of the view of the players. Players will then look around the scene to find the characters, which will be hiding in locations provided by the Holoscanner backend. The characters will make sounds to help the players find them. To catch a character, a player must be within a certain distance (around 1m) of the character, look directly at them (cursor over them), and air tap. The character will then run off to hide elsewhere, and the players score will increase by one. For simplicity's sake, this continues until a preset number of characters are found or a time limit expires, after which the player with the highest score is declared the winner.

### Game Look and Feel
The game will have very few elements on the display. There will simply be a scoreboard on the HUD showing how many objectives each player has found, as well as a separate score for the current player. The standard cursor in the center of the screen for air-taps will also be present. Other than this, the only other things that will appear will be the hidden characters. As mentioned above, each hidden character will emit spatialized sound to help
players locate them.

## Performance Metrics
 
- Mesh completeness can be evaluated quantitatively in several ways. One simple metric is to compute the total length of mesh edges incident on only one mesh face (since these correspond to "edges" of the mesh) relative to the total surface area of the mesh. Depending on our backend system, we can also evaluate the scene volumetrically, tracking the number of unobserved voxels vs. free space/occupied voxels. However, this is unlikely to be computationally feasible in an online setting.
- Quantitative accuracy of the reconstructed 3D model. We can use state-of-the-art 3D reconstruction systems to scan the same environment to provide a "ground truth". Then we can quantitatively compare our reconstruction with theirs by computing the distance to the nearest surface on the ground truth mesh for each vertex (or uniformly sampled set of points) in our reconstructed mesh.
- Qualitative improvement of the reconstructed 3D model over time, especially in difficult or cluttered regions of the scene. This can be demonstrated using a video that highlights mesh accuracy from first scans of the room until the end of game, of e.g. a desk (where e.g. initially monitors are not captured and there are holes in the desk)
- Suitability of hidden-objective locations can be evaluated by tracking our quantitative metrics above over time, and determining how well they correlate with when players find objectives during the game. We can also compare with a "control player" who does not actively try to locate objectives, but simply wanders around the room (since this will likely also increase the metrics by a small amount over time)

## Milestones

### Week 1 (April 20)
 * framework (protocol, central server, basic game loop)

### Week 2 (April 27)
 * Transmissions of mesh and messages between server and client. 

### Week 3(May 4)
 * Multiple mesh alignment
 * Minimal gameplay and interface
 * Initial results for mesh refinement and missing region identification

### Week 4 (May 11)
 * Improved refinement
 * Improved identification of missing and misaligned regions

### Week 5 (May 18)
 * Complete gameplay system
 * Finished region selection method integrated into game
 * Working single-player version of game.

### Week 6 (May 25)
 * Iterate and playtest for end-to-end gameplay and in-game mesh quality.
 * Integrated game using mesh alignment from multiple clients.

### Week 7 (June 1)
 * Evaluate final reconstructed 3D model of the room (qualitative, quantiative)
 * Prototype basic application using high-quality model

### Week 8 (June 8)
 * Working demo for game
 * Polish application using high-quality model.


## Responsibilities

**Hamid Izadinia:**

 * Mesh alignment
 * Identify missing mesh regions

**Edward Zhang:**

 * Gameplay experience
 * Mesh refinement

**Aleksander Holynski:**

 * Core game architecture in Unity
 * Mesh inconsistency measurement
 * Animated character placement

**Keunhong Park:**

 * Cloud server and protocols
 * Identify unscannable regions
 
 
## Materials and Budget
 
We need 3D assets for the gameplay. Depending on gameplay complexity, we estimate a $40 asset budget for a simple hide-and-seek game (one or two characters or props to hide) or
up to $200 for a more complex game (e.g. territory acquisition game, capture-the-flag game) with multiple characters and many game props and scene elements

We also may run our backend on a commercial cloud service such as [AWS](https://aws.amazon.com). As an upper bound on the cost of these services,
we estimate that for 10 hours/week of active testing over the second half of the quarter (the initial testing can be done on local containers).
Using `g2.8xlarge` AWS GPU instances (which are probably overkill), which are $2.60/hour for on-demand instances, that works out to $130. Moving down to `g2.2xlarge` instances reduces this estimate to about $30.
Storage and server machines have minimal (less than $5) or no additional cost for our applications, at least for testing purposes.
