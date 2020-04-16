# Technology Stack

A technology stack is a "are the frameworks, languages, and software products"[@WhatTechnologyStack] that developers use to build an application. In this section we give a high level overview of the technologies we used to build MTA Hub and give an overview of how all of these technologies fit together.

## Web application frameworks {#sec:libs-frontend}

In [@sec:bg-api-analysis] we evaluated a number of existing APIs; based on that information we decided to adopt a REST architectural style in designing our API.

We chose to build a single page application as SPAs are typically easy to transform into _progressive web applications_, which "deliver native-like capabilities, reliability, and installability while reaching _anyone, anywhere, on any device_ with a single codebase" [@WhatMakesGood].

Of Ryan Donovan's _Top 10 Frameworks_ [-@Top10Frameworks], React, Angular and Vue were the top frontend frameworks that support single page applications.

We did not have any experience with Vue, but had worked with Angular and React before, so we did not consider Vue for this project. Despite React being more popular than Angular [@AngularVsReact] we chose Angular as it is "a full-fledged framework for software development, which usually does not require additional libraries" [@AngularVsReact]. This allows us to develop rapidly and lets us focus on building the application, compared to React which "is unopinionated and leaves developers to make choices about the best way to develop" [@ReactVsAngular].

We were particularly drawn to Angular's in-built `ng` command line interface, which:

- gives us a standard project structure to use from the start which decreases developer overhead and makes it easy for new contributors to join the project.
- can generate new modules, components, services and directives quickly (these concepts are discussed in [@sec:angular-concepts]).
- automatically generates foundational tests, which encourages test-driven development.

Angular also had an inbuilt internationalisation library which we could use to handle pluralisation, string extraction, number formatting, and date formatting. According to Angular's guide, "_Internationalization_ is the process of designing and preparing your app to be usable in different languages" [@AngularInternationalizationI18n].

### Angular concepts {#sec:angular-concepts}

Angular has the following concepts:

- Components: functional views which have associated TypeScript have HTML templates and CSS styles associated with them, and are included in other HTML templates.
- Directives: extend the templating system, making it possible to add new HTML attributes.
- Services: persistent single classes that are shared between components.
- Modules: which can import other modules, declare components & directives, and export components & directives.

All of these concepts are implemented as TypeScript classes. Components and Directives can only interact with each other through services, and these services are _injected_ into the class via the constructor. This process is known as _dependency injection_ and it enhances software testing by allowing "dependencies to be mocked or stubbed out" [@DesignPatternsWhat].

Note that every module imports the `CommonModule` module from the Angular standard library.

### Modules {#ec:modules}

The modules that we created are:

- AppModule - handles the entire application
    - AppRoutingModule - handles routing for the entire application
    - UserModule - provides a service to interact with all user _information_
    - ProfileModule - provides components to interact with all user _profile pages_
        - ProfileRoutingModule - handles routes relating to a user's profile
    - ResourceModule - provides services and components that interact with all resources
        - ResourceRoutingModule - handles routes relating to an individual resource
    - AuthModule - provides services and components relating to user _authentication_
    - OcticonModule - provides a directive to create "octicon" images across the website

Routing is discussed in more detail in [@sec:routing].

### CSS frameworks

We wanted a CSS framework that had the following properties:

- **responsive**: so that we can support mobile and desktop screen sizes
- **utility classes**: makes it easier to rapidly prototype the interface
- **flexbox**: provides "a more efficient way to lay out, align and distribute space among items in a container" [@CompleteGuideFlexbox]
- **Angular support**: the framework should work with Angular

We were initially drawn to Bootstrap as it satisfies all the constraints and we had previous experience using the framework. We discovered that Bootstrap 4 uses jQuery, which is a dependency that does not align with the declarative nature of Angular, and can cause bugs if used improperly.

For this reason, we chose Primer - GitHub's open-source design system. Since GitHub is similar to MTA Hub in that both platforms allow users to upload software archives, we could also leverage Primer's additional inbuilt components that are missing in Bootstrap, as shown in [@fig:primer-timeline] and [@fig:primer-blankslate].

!["The `TimelineItem` component is used to display items on a vertical timeline, connected by `TimelineItem-badge` elements." [@TimelinePrimerCSS]](chapters/30-impl/assets/primer-timeline.png){#fig:primer-timeline}

!["Blankslates are for when there is a lack of content within a page or section. Use them as placeholders to tell users why something isn't there." [@BlankslatePrimerCSS]](chapters/30-impl/assets/primer-blankslate.png){#fig:primer-blankslate}

## Backend

We had three main reasons for choosing to build our API in Go:

1. Go compiles down to a single statically linked binary, making it easy to deploy.
2. Go is highly performant compared to the other languages we considered, while also being memory safe, type safe and mostly free of undefined behaviour.
3. Go does not slow the developer down: we can write code quickly, that code builds fast, and its runtime behaviour is predictable.

Go's webserver is multithreaded by default which improves its performance, but also makes it susceptible to Go's only undefined behaviour: _race conditions_. We can make use of Go's inbuilt concurrency primitives - _channels_ - to alleviate this problem^[More information on Go's concurrency features can be found at: https://github.com/golang/go/wiki/LearnConcurrency].

We also had the most prior experience writing software in Go, making the language an obvious choice.

Other languages we considered were:

- Python, which lacks many of the above properties. It is interpreted and weakly typed, resulting in a lot of runtime overhead, and therefore poor performance. While it is the fastest to write and does not need compiling, the lack of static typing makes it susceptible to runtime errors which could easily be resolved at compile time.
- Rust can be statically linked and has better performance than Go, but it is slow to write and compile, making it difficult to build and experiment with.
- C++ has the best performance but is not memory safe or free of undefined behaviour. These two properties would make the backend at risk of being vulnerable through memory exploits. A lot of developer time would be spent being extra careful to prevent the introduction of security vulnerabilities. Compile time is also an issue — "Go is significantly faster to compile over C++" [@GoVsComparison].

## Database

Storing information in a database allows us to persist data across multiple independent requests. We chose to store our data in a PostgreSQL database as:

- the database for the existing system is stored in PostgreSQL, making migration easier
- f

## Deployment {#sec:deploy}

// TODO: citations

Deployment is an important part of creating a web platform — merely building an application is insufficient, it should be easy to deploy locally (for development) as well as to deploy in the production environment.

To make it easier for contributors to develop, we will use Docker and docker-compose to create a consistent development workspace.

This has the following advantages:

- Potential contributors can quickly "spin up" a local instance of the website and can make improvements quickly.
- A seasoned contributor can spend more time developing, and less time helping new contributors get started.
- Support for Windows comes "for free" - less effort can spent in making our project work in non-POSIX-compliant environments.

We intend for this same Docker image to be used in production, keeping the development environment as close to the production environment as possible. This helps keep environment or configuration-related bugs to a minimum.


## Overview

