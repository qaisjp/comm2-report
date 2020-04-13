# Choosing a CSS framework

We wanted to choose a CSS framework that had the following features:

- **responsive**: so that we can support mobile and desktop screen sizes
- **utility classes**: makes it easier to rapidly prototype the interface
- **flexbox**: provides "a more efficient way to lay out, align and distribute space among items in a container" [@CompleteGuideFlexbox]
- **Angular support**: the framework should work with Angular

We were initially drawn to Bootstrap as it satisfies all the constraints and we had previous experience using the framework. We discovered that Bootstrap 4 uses jQuery, which is a dependency that does not align with the declarative nature of Angular, and can cause bugs if used improperly.

For this reason, we chose Primer - GitHub's open-source design system. Since GitHub is similar to MTA Hub in that both platforms allow users to upload software archives, we could also leverage Primer's additional inbuilt components that are missing in Bootstrap, as shown in [@fig:primer-timeline] and [@fig:primer-blankslate].

!["The `TimelineItem` component is used to display items on a vertical timeline, connected by `TimelineItem-badge` elements." [@TimelinePrimerCSS]](chapters/30-design/assets/primer-timeline.png){#fig:primer-timeline.png}

!["Blankslates are for when there is a lack of content within a page or section. Use them as placeholders to tell users why something isn't there." [@BlankslatePrimerCSS]](chapters/30-design/assets/primer-blankslate.png){#fig:primer-blankslate.png}

**Bootstrap**

Bootstrap was originally built by Twitter
Primer provides tools that is responsive, accessible and has a lot

talk about primer grid - responsiveness. bootstrap has this. the reason we chose primer is because it's the backbone of github, and our service follows a similar format to github, so we have all the necessity taxonomies available. also bootstrap 4 requires jquery (explain why jquery is bad and unnecessary today), and that we're waiting for bootstrap 5 which does not use jquery.
