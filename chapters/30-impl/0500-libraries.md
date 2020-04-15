# Frontend

## Web application frameworks

In [@sec:bg-api-analysis] we evaluated a number of existing APIs; based on that information we have decided to adopt a REST architectural style in designing our API.

We have chosen to build a progressive web application as it allows us to "deliver native-like capabilities, reliability, and installability while reaching _anyone, anywhere, on any device_ with a single codebase" [@WhatMakesGood].

According to Ryan Donovan's _Top 10 Frameworks_ [-@Top10Frameworks], React, Angular and Vue are the top frontend frameworks. We have excluded the other frameworks from the list as they are not relevant to frontend frameworks or progressive web applications.

We do not have any experience with Vue, but have worked with Angular and React before, so we did not consider Vue. Despite React being more popular than Angular [@AngularVsReact] we have chosen to work with Angular as it is "a full-fledged framework for software development, which usually does not require additional libraries" [@AngularVsReact]. This is particularly important to us as it allows us to develop rapidly and lets us focus on building the application, compared to React which "is unopinionated and leaves developers to make choices about the best way to develop" [@ReactVsAngular].

Angular also has an inbuilt internationalisation library which we can use to handle pluralisation, string extraction, number formatting, and date formatting. According to Angular's guide, "_Internationalization_ is the process of designing and preparing your app to be usable in different languages" [@AngularInternationalizationI18n].

## CSS frameworks

We wanted to choose a CSS framework that had the following features:

- **responsive**: so that we can support mobile and desktop screen sizes
- **utility classes**: makes it easier to rapidly prototype the interface
- **flexbox**: provides "a more efficient way to lay out, align and distribute space among items in a container" [@CompleteGuideFlexbox]
- **Angular support**: the framework should work with Angular

We were initially drawn to Bootstrap as it satisfies all the constraints and we had previous experience using the framework. We discovered that Bootstrap 4 uses jQuery, which is a dependency that does not align with the declarative nature of Angular, and can cause bugs if used improperly.

For this reason, we chose Primer - GitHub's open-source design system. Since GitHub is similar to MTA Hub in that both platforms allow users to upload software archives, we could also leverage Primer's additional inbuilt components that are missing in Bootstrap, as shown in [@fig:primer-timeline] and [@fig:primer-blankslate].

!["The `TimelineItem` component is used to display items on a vertical timeline, connected by `TimelineItem-badge` elements." [@TimelinePrimerCSS]](chapters/30-impl/assets/primer-timeline.png){#fig:primer-timeline.png}

!["Blankslates are for when there is a lack of content within a page or section. Use them as placeholders to tell users why something isn't there." [@BlankslatePrimerCSS]](chapters/30-impl/assets/primer-blankslate.png){#fig:primer-blankslate.png}

# Backend

We had three main reasons for choosing to build our API in Go:

1. Go compiles down to a single statically linked binary, making it easy to deploy (see [@sec:deploy]).
2. Go has fantastic performance whilst also being memory safe, type safe and mostly free of undefined behaviour.
3. Go does not slow the developer down.

Go's webserver is multithreaded by default which improves its performance, but also make it susceptible to Go's only undefined behaviour: _race conditions_. We can make use of Go's inbuilt concurrency primitives - _channels_ - to alleviate this problem^[More information on Go's concurrency features can be found at: https://github.com/golang/go/wiki/LearnConcurrency].

We also had the most prior experience writing software in Go, making the language an obvious choice.

Other languages we considered were:

- Python, which lacks many of the above properties. It is interpreted and duck-typed, resulting in a lot of runtime overhead, and therefore poor performance. Whilst it is the fastest to write and does not need compiling, the lack of static typing makes it susceptible to runtime errors which could easily be resolved at compile time.
- Rust can be statically linked and has better performance than Go, but it is slow to write and compile, making it difficult to build and experiment with.
- C++ has the best performance but is not memory safe or free of undefined behaviour. These two properties would make the backend at risk of being vulnerable through memory exploits. A lot of developer time will be spent being extra careful to prevent the introduction of security vulnerabilities. Compile time is also an issue — "Go is significantly faster to compile over C++" [@GoVsComparison].
