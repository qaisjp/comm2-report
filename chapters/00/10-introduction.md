\chapter{Introduction}
\pagenumbering{arabic}
\setcounter{page}{1}

# Motivation

In 2006 a community platform was written in PHP for the MTA:SA community, allowing users to share, vote and discuss resources. In 2006 many web applications did not consider security and user experience, and MTA's community platform was no exception.

This project replaces the existing platform with an improved system that abides by these fundamentals.

# Contributions

I was able to rewrite the base functionality of the existing platform, allowing users to create new resources and upload additional versions, with following additional features:

- Compared to the previous system, resources are no longer globally scoped and are scoped per user.
- Owners of resources now have greater permissions than individual authors, preventing those individual contributors from performing destructive actions.
- With the power of Markdown, authors now have a better tool to market their resource.
- Website internationalisation has been replaced with a system that is more powerful and more sustainable.
- User interface and user experience has been improved, allowing for greater user retention.
- The website has been made responsive, allowing for mobile users to perform actions properly.
- The website has been developed with security in mind, keeping it safe from bad actors.


# Structure

- Chapter 2 discusses and analyses the existing platform - highlighting security vulnerabilities and areas where user experience could be improved.
- Chapter 3 explores the challenges in designing and implementing MTA Hub, discusses further design decisions, and explains how features were introduced. This chapter also analyses existing websites relevant to MTA Hub, to help influence our design decisions.
- Chapter 4 evaluates the platform in terms of speed, whether it satisfies the non-functional requirements, and summarises user feedback.
- Chapter 5 concludes the work completed and outlines potential future extensions.

# Terminology {#sec:terminology}

The terminology used throughout this report has been chosen carefully as to not be ambiguous, but may not apply when referring to other systems.

- `resource`: a collection of assets (scripts, images, models, audio files) — "partly equivalent to a program running in an operating system" [@ResourcesMultiTheft]

    A resource can be of the following types [@MetaXmlMulti]:

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
    - `sysadmin`: system administrator, an administrator that deploys and has full access to the platform
    - `contributor`: someone who contributes code to this project (does not necessarily have special permissions)
- users:
    - `scripter`: someone that authors _resources_
    - `server owner`: a non-technical `server` owner
