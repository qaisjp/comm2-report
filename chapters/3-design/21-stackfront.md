## Web application frameworks {#sec:libs-frontend}

In [@sec:bg-api-analysis] we evaluated a number of existing APIs; based on that information we decided to adopt a REST architectural style in designing our API.

We chose to build a single page application as SPAs are typically easy to transform into _progressive web applications_, which "deliver native-like capabilities, reliability, and installability while reaching _anyone, anywhere, on any device_ with a single codebase" [@WhatMakesGood].

Of Ryan Donovan's _Top 10 Frameworks_ [-@Top10Frameworks], React, Angular and Vue were the top frontend frameworks that support single page applications.

We did not have any experience with Vue, but had worked with Angular and React before, so we did not consider Vue for this project. Despite React being more popular than Angular [@AngularVsReact] we chose Angular as it is "a full-fledged framework for software development, which usually does not require additional libraries" [@AngularVsReact]. This allows us to develop rapidly and lets us focus on building the application, compared to React which "is unopinionated and leaves developers to make choices about the best way to develop" [@ReactVsAngular].

We were particularly drawn to Angular's in-built `ng` command line interface, which:

- gives us a standard project structure to use from the start which decreases developer overhead and makes it easy for new contributors to join the project.
- can generate new modules, components, services and directives quickly.
- automatically generates foundational tests, which encourages test-driven development.

Angular also had an inbuilt internationalisation library which we could use to handle pluralisation, string extraction, number formatting, and date formatting. According to Angular's guide, "_Internationalization_ is the process of designing and preparing your app to be usable in different languages" [@AngularInternationalizationI18n].

### Angular concepts {#sec:angular-concepts}

Angular has the following concepts:

- Components: functional views which have associated TypeScript have HTML templates and CSS styles associated with them, and are included in other HTML templates.
- Directives: extend the templating system, making it possible to add new HTML attributes.
- Services: persistent single classes that are shared between components.
- Modules: which can import other modules, declare components & directives, and export components & directives.

All of these concepts are implemented as TypeScript classes. Components and Directives can only interact with each other through services, and these services are _injected_ into the class via the constructor. This process is known as _dependency injection_ and it enhances software testing by allowing "dependencies to be mocked or stubbed out" [@DesignPatternsWhat].

### CSS frameworks

We wanted a CSS framework that had the following properties:

- **responsive**: so that we can support mobile and desktop screen sizes
- **utility classes**: makes it easier to rapidly prototype the interface
- **flexbox**: provides "a more efficient way to lay out, align and distribute space among items in a container" [@CompleteGuideFlexbox]
- **Angular support**: the framework should work with Angular

We were initially drawn to Bootstrap as it satisfies all the constraints and we had previous experience using the framework. We discovered that Bootstrap 4 uses jQuery, which is a dependency that does not align with the declarative nature of Angular, and can cause bugs if used improperly.

!["The `TimelineItem` component is used to display items on a vertical timeline, connected by `TimelineItem-badge` elements." [@TimelinePrimerCSS]](chapters/3-design/assets/primer-timeline.png){#fig:primer-timeline}

!["Blankslates are for when there is a lack of content within a page or section. Use them as placeholders to tell users why something isn't there." [@BlankslatePrimerCSS]](chapters/3-design/assets/primer-blankslate.png){#fig:primer-blankslate}

For this reason, we chose Primer - GitHub's open-source design system. Since GitHub is similar to MTA Hub in that both platforms allow users to upload software archives, we could also leverage Primer's additional inbuilt components that are missing in Bootstrap, as shown in [@fig:primer-timeline] and [@fig:primer-blankslate].
