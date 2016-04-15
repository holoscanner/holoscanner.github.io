---
layout: default
title: Project Requirements Document
---

## Summary

_Holoscanner is a system that improves the 3D scan of an indoor scene by processing of the depth data stream from multiple Hololens devices in a multiplayer game scenario. The primary objective in this application is producing a high-quality 3D mesh which accurately models the scene around the players. This involve alignment of the global model across multiple devices and merging the observations into a globally optimal model that is consistent with the input data from each player’s Hololens. There will be a quantitative scoring function which measures the inconsistency between the aligned mesh inputs and determining the regions that needs to be scanned and also finding complex unscannable regions. Once they have been identified, the gameplay will cue users to move towards different regions to provide additional observations._


## Deliverables
 
- A multiplayer game application that encourages player to move around the scene

- The visualization of the 3D scan of the room and showing how it improves over time

- An application scenario that uses the produced accurate 3D scan of the room


 
## Critical Features
 
- ***Mesh alignment and refinement***

   The server receive the depth data from each device and should be able to find an accurate alignment between coordinate of multiple devices.

- ***Mesh quality measure***

   The evaluation function should consider the consistency of the global reconstructed model and measure the accuracy in each region of the 3D model.

- ***Front-end experience (gameplay)***

   The gameplay scenario should be interesting and encourage players to move around the game environment for capturing all regions of the room from different views.  

## Performance Metrics
 
Qualitative improvement of the reconstructed 3D model over time using a video that highlight mesh accuracy from first scans of the room until the end of game.

## Milestones

-- April 20: framework (protocol, central server, basic game loop)

-- April 27: mesh alignment

-- May 4: initial results for mesh refinement

-- May 11: finish refinement and identification of missing and misaligned regions

-- May 18: complete gameplay system 

-- May 25: finish region selection method and deploy it in game 

-- June 1: evaluate final reconstructed 3D model of the room

-- June 8: prepare demo for game and extra application


## Responsibilities

**Hamid Izadinia:** mesh alignment, identify missing mesh regions

**Edward Zhang:** front-end experience (gameplay), mesh refinement

**Aleksander Holynski:** game loop design in unity, mesh inconsistency measurement and animated character placement

**Keunhong Park:** central server of the game and protocols, identify unscannable regions 


 
 
## Materials and Budget
 
We need 3D assets for the gameplay. Our initial estimation is $200 for purchasing animated characters and different game scenes.




