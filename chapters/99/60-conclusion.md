\chapter{Conclusion}

# Overview

I achieved some of the project goals by creating a secure web application that allows users to share, discover and download resources.

Yes, more efficient, better infrastructure, more secure. Easier to develop.


# Extensions

Further work includes implementing the changes suggested in Chapter 5 (Evaluation). More ambitious extensions to the system have been outlined below:

## Shared authentication

MTA has a wide variety of services: forum, server listing manager, wiki, staff area, and of course this project - "community". Each of these services use a separate authentication system, and we could unify these by implementing an OAuth Provider.

This can help improve access control as senior staff can manage all permissions in one place, but reduce security as there is a single point of failure.

## Social features

An additional stakeholder, not mentioned in [@sec:terminology], are "players". A "player" is a user that connects to a server and interacts with these _resources_.

We could provide social features for these players, allowing them to add other users as friends, find what server their friends are on, and track in game statistics.

## Additional taxonomy

Resources aren't the only kind of shareable "object" available to the MTA community. We could add additional support for sharing skins and sharing vehicle handlings.

**Skin sharing**

The MTA client is customisable and users can install custom themes that alter the way the user interface looks. We can provide a way for graphic designers to publish these skins, and allow users to preview these skins in the browser. Additionally, we can make use of URI schemes to providing single-click installations of these skins.

**Vehicle handlings**

Vehicles (cars, planes, trains and boats) in the game client are tunable, and users may want to persist these changes across servers, or share the se configurations with other users. We could provide a service to share these via a URL, make it possible to create them in the browser, and even include an in-browser simulation of the vehicle handlings.

## Support diagnostics

Users may submit forum topics or join live chat to get help with MTA's resource. Sometimes we need to collect diagnostic data and so moderators direct them to install "MTA Diag"^[MTADiag is available on GitHub - https://github.com/multitheftauto/mtadiag]. This generates a text file which is automatically uploaded to our internal Pastebin service, providing vital information to moderators, helping them diagnose the user's problem.

We could extend MTA Hub to support parsing of these text files or process more structured data and present the information in a more user friendly way, such as introducing collapsible sections or the ability to highlight potential problems.

In case of an influx of similar support requests, individual diagnostic reports could be "tagged" or "linked" to a GitHub issue that discusses the problem. This would also "star" the report, changing the retention period from 2 weeks to a much longer time period. After enough reports are gathered, the system could search for similarities across reports to help find the common problem.
