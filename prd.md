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
