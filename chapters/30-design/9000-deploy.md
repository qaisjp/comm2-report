# Deployment {#sec:design-deployment}

Deployment is an important part of creating a web platform — merely building an application is insufficient, it should be easy to deploy locally (for development) as well as to deploy in production.

To make it easier for contributors to develop, we will use Docker and docker-compose to create a consistent development workspace.

This has the following advantages:

- Potential contributors can quickly "spin up" a local instance of the website and can make improvements quickly.
- A seasoned contributor can spend more time developing, and less time helping new contributors get started.
- Support for Windows comes "for free" - less effort can spent in making our project work in non-POSIX-compliant environments.

We intend for this same Docker image to be used in production, keeping the development environment as close to the production environment as possible. This helps keep environment or config related bugs to a minimum.
