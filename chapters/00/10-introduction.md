\chapter{Introduction}

<!--
It should be 30 to 60 pages long, and preferably no shorter than 20 pages.
Appendices are in addition to this and you should place detail here which may be too much
or not strictly necessary when reading the relevant section.
-->

# Motivation

Motivation

# Contributions

# Structure

- Chapter 2 discusses and analyses the existing platform, existing package management websites (software repositories), and existing API-driven websites.
- Chapter 3 explains and discusses initial project setup and the initial (design) decisions that went into building MTA Hub.
- Chapter 4 explores the challenges in implementing MTA Hub, discusses further design decisions, and explains how features were introduced.
- Chapter 5 evaluates the platform in terms of speed, whether it satisfies the non-functional requirements, and summarises user feedback.
- Chapter 6 concludes the work completed and outlines potential future extensions.

# Terminology {#sec:terminology}

The terminology used throughout this report has been chosen carefully as to not be ambiguous, but may not apply when referring to other systems.

- `resource`: a collection of assets (scripts, images, models, audio files) — "partly equivalent to a program running in an operating system" [@ResourcesMultiTheft]

    A resource can be of the following types [@lyonsedwinMetaXmlMulti2008]:

    - `gamemode` - provides core game mechanics
    - `map` - a collection of game world objects, allowing for unique twists on the core mechanics provided by gamemodes
    - `script` - may provide extra features that interact gamemodes
    - `misc` - utility resources
- `package`: a particular version of a resource, when differentiating between versions is important
- `server`: an instance of the game server (which can run many resources)

These terms describe the stakeholders:

- maintainers:
    - `moderator`: someone that issues bans or reviews content, keeping the platform safe
    - `administrator`: a moderator that also manages user permissions
    - `sysadmin`: an administrator that deploys and has full access to the platform
    - `contributor`: someone who contributes code to this project (does not necessarily have special permissions)
- users:
    - `scripter`: someone that authors _resources_
    - `mapper`: someone that primarily creates _resources_ of the _map_ type
    - `server owner`: a user that manages a `server` but is not necessarily technical (does not have to be a `scripter` or `mapper`)
    - `player`: a user that connects to a `server` and interacts with _resources_
