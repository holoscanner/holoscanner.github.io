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
 
- Qualitative improvement of the reconstructed 3D model over time using a video that highlights mesh accuracy from first scans of the room until the end of game.

## Milestones

-- April 20: framework (protocol, central server, basic game loop)

-- April 27: multiple mesh alignment, minimal gameplay and interface

-- May 4: initial results for mesh refinement and missing region identification

-- May 11: improved refinement and identification of missing and misaligned regions

-- May 18: complete gameplay system, finish region selection method and integrate it into game

-- May 25: iterate and playtest for end-to-end gameplay and in-game mesh quality

-- June 1: evaluate final reconstructed 3D model of the room, basic application for high-quality model

-- June 8: prepare demo for game and refine application of high-quality model


## Responsibilities

**Hamid Izadinia:** mesh alignment, identify missing mesh regions

**Edward Zhang:** gameplay experience, mesh refinement

**Aleksander Holynski:** core game architecture in Unity, mesh inconsistency measurement and animated character placement

**Keunhong Park:** cloud server and protocols, identify unscannable regions


 
 
## Materials and Budget
 
We need 3D assets for the gameplay. Depending on gameplay complexity, we estimate a $40 asset budget for a simple hide-and-seek game (one or two characters or props to hide) or
up to $200 for a more complex game (e.g. territory acquisition game, capture-the-flag game) with multiple characters and many game props and scene elements

We also may run our backend on a commercial cloud service such as [AWS](https://aws.amazon.com). As an upper bound on the cost of these services,
we estimate that for 10 hours/week of active testing over the second half of the quarter (the initial testing can be done on local containers).
Using `g2.8xlarge` AWS GPU instances (which are probably overkill), which are $2.60/hour for on-demand instances, that works out to $130. Moving down to `g2.2xlarge` instances reduces this estimate to about $30.
Storage and server machines have minimal (less than $5) or no additional cost for our applications, at least for testing purposes.
