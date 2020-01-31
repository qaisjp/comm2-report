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
- Chapter 3 explains and discusses initial project setup and the initial (design) decisions that went into building MTA Hub
- Chapter 4 explores the challenges in implementing MTA Hub, discusses further design decisions, and explains how features were introduced.
- Chapter 5 evaluates the platform in terms of speed, whether it completes the requirements, and summarises user feedback
- Chapter 6 concludes the work completed and outlines potential future extensions

# Terminology

The terminology used throughout this report has been chosen carefully as to not be ambiguous, but may not apply when referring to other systems. These terms also describe the stakeholders.

- `resource`: a collection of assets (scripts, images, models, audio files) — "partly equivalent to a program running in an operating system" [^what-is-a-resource]
- `package`: a particular version of a resource, when differentiating between versions is important
- (of the platform)
    - `maintainer`: someone who contributes code to this project (does not necessarily have special permissions)
    - `sysadmin`: a super administrator that deploys and has full access to the platform
    - `moderator` or `reviewer`: someone that issues bans or reviews content, keeping the platform safe
- `server`: an instance of the game server (which can run many resources)
- `scripter`: someone that authors _resources_
- `mapper`: someone that authors _resources_ of the `map` type
- `server owner`: a user that manages a `server` but is not necessarily technical (does not have to be a `scripter` or `mapper`)
- `player`: a user that connects to a `server` and enjoys experiences offered by `resources`

[^what-is-a-resource]: https://wiki.multitheftauto.com/wiki/Resources
