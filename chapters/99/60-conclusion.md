\chapter{Conclusion}

# Overview

We achieved some of the project goals by creating a secure web application that allows users to share, discover and download resources.

We made the web application more efficient, be built using better infrastructure, and take into account secure practices. It is also much easier for contributors to develop with.




# Extensions

Further work includes implementing the changes suggested in our Evaluation chapter. More ambitious extensions to the system have been outlined below:

## Shared authentication

MTA has a wide variety of services: forum, server listing manager, wiki, staff area, and of course this project - "community". Each of these services use a separate authentication system, and we could unify these by implementing an OAuth Provider. This would allow other platforms that support OAuth to use MTA Hub's authentication system as a login mechanism.

This would help improve access control as senior staff can manage all permissions in one place, but reduce security as there is a single point of failure.

## Social features

An additional stakeholder, not mentioned in [@sec:terminology], are "players". A "player" is a user that connects to a server and interacts with these _resources_.

We could provide social features for these players, allowing them to add other users as friends, find what server their friends are on, and track in-game statistics.

## Additional taxonomy

Resources aren't the only kind of shareable "object" available to the MTA community. We could add additional support for sharing skins and sharing vehicle handlings.

**Skin sharing**

The MTA client is customisable and users can install custom themes that alter the way the user interface looks. We could provide a way for graphic designers to publish these skins, and allow users to preview these skins in the browser. Additionally, we can make use of URI schemes to providing single-click installations of these skins.

**Vehicle configurations**

The way vehicles (cars, planes, trains and boats) behave in the game client are customisable, and users may want to persist these changes across servers, or share these configurations with other users. We could provide a service to share these via a URL, make it possible to create them in the browser, and even include an in-browser simulation of the vehicle configurations.

## Support diagnostics

Users may submit forum topics or join live chat to get help with MTA's default resources. Sometimes we need to collect diagnostic data and so moderators direct them to install "MTA Diag"^[MTADiag is available on GitHub - https://github.com/multitheftauto/mtadiag]. MTA Diag generates a text file containing system information, automatically uploads that file to our internal Pastebin service (saved for two weeks), and prompts the user to share the file with us. This file provides vital information to help moderators diagnose the user's problem.

We could extend MTA Hub to support structured processing of this data, and then present this information in a more user friendly way, such as introducing collapsible sections or the ability to highlight potential problems.

Diagnostic reports would ordinarily be saved for two weeks, but staff would be able to mark the report as _starred_, changing the retention period from two weeks to a much longer time period.

In case of an influx of similar support requests, individual diagnostic reports could be "tagged" with metadata or "linked" to a GitHub issue that discusses the problem. After enough reports are gathered, the system could search for similarities across reports to help find the common problem.
