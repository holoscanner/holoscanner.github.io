---
layout: default
title: Project Proposal
---

## Abstract

_The Hololens has the capabilities to produce good quality 3D scans of indoor scenes, but spending time scanning a room can be a tedious process. In order to view objects, perform tasks, or even play games, Hololens users spend a lot of time looking around and exploring their environments, so why not design applications that encourage this exploration to occur in regions which need to be scanned?_

_We propose creating a game which, as a result of its mechanics, causes the players to inadvertently produce an accurate and complete scan of their surroundings._

## The Gameplay

Currently, we are considering a number of gameplay options. Our goal is to produce a convincing and entertaining experience that successfully obfuscates the ulterior motive of scanning the room. The following is our current draft of the gameplay, although we are open to other ideas. 

### Option 1: Hide and Seek

The game state begins with the players standing in a room. As the application launches, a number of bunnies appear in the room, but quickly scurry away. 
![The start state](images/bunnies.png)

The goal becomes to find the bunnies before the other players. Players will search the explorable space for the bunnies. Spatial sound cues will be given to lead players in the general direction of bunnies. Once found, bunnies will reappear in other parts of the scene until some criteria is met. 

Behind the scenes, the placement of bunnies is selected based on regions of the room which require additional scanning. By placing bunnies near regions that need scanning, players will likely move their gaze through that region, providing additional observations to refine the 3D model.  

## The Scanning

The primary objective in this application is producing a high-quality 3D mesh which accurately models the scene around the players. Doing this involves identifying regions that need to be scanned. These regions can be regions that haven't yet been scanned by any of the players, or even regions with inconsistent models across multiple Hololens devices. Once these regions are identified, the gameplay will cue users to move towards that region to provide additional observations.

## Technical Challenges

### Multiplayer

#### Mesh Alignment

#### Model Consistency

### Mesh Region Scoring

### Termination Criteria

### Scene Complexity and Unscannable Regions

## Device Questions and Concerns


