## Deployment {#sec:deploy}

Deployment is an important part of creating a web platform — merely building an application is insufficient, it should be easy to deploy locally (for development) as well as to deploy in the production environment.

To make it easier for contributors to develop, we use Docker to create a consistent development environment for the backend. Docker allows us to "easily pack, ship, and run any application as a lightweight, portable, self-sufficient container, which can run virtually anywhere" [@WhatDockerWhy]. This gives us the following advantages:

- Potential contributors can quickly "spin up" a local instance of the website and can make improvements quickly.
- A seasoned contributor can spend more time developing, and less time helping new contributors get started.
- Our project will automatically be supported on operating systems that are not POSIX-compliant, and we can spend less time supporting those non-compliant operating systems.

    Portable Operating System Interface for Unix (POSIX) is "a set of [IEEE] standards that define how to develop programs for UNIX (and its variants)". Windows is one example of a non-POSIX compliant operating system.

We intend for this same Docker image to be used in production, keeping the development environment as close to the production environment as possible. This helps keep environment or configuration-related bugs to a minimum.

The Angular command line interface ensures that the tools currently being used match the version defined in the repository's `package.json` file, so we do not need to use Docker for the frontend.

<!-- TODO: add actual docker config discussion in implementation -->
