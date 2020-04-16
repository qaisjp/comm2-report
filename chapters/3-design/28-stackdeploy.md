## Deployment {#sec:deploy}

Deployment is an important part of creating a web platform — merely building an application is insufficient, it should be easy to deploy locally (for development) as well as to deploy in the production environment.

To make it easier for contributors to develop, we use Docker to create a consistent development environment for the backend. Docker allows us to "easily pack, ship, and run any application as a lightweight, portable, self-sufficient container, which can run virtually anywhere" [@WhatDockerWhy]. This gives us the following advantages:

- Potential contributors can quickly "spin up" a local instance of the website and can make improvements quickly.
- A seasoned contributor can spend more time developing, and less time helping new contributors get started.
- Support for Windows comes "for free" - less effort can spent in making our project work in non-POSIX-compliant environments.

We intend for this same Docker image to be used in production, keeping the development environment as close to the production environment as possible. This helps keep environment or configuration-related bugs to a minimum.

The Angular command line interface ensures that the tools currently being used match the version defined in the repository's `package.json` file, so we do not need to use Docker for the frontend.
