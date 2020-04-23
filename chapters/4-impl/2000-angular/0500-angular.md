# Angular

This section describes the high-level design and implementation of our Angular frontend.

## Logging

We created a `LogService` to handle logging centrally throughout our application. Traditionally logging is handled using the `console.log` function, but this is not the "best practice for production applications" [@LoggingAngularApplications].

At the moment our `LogService` is extremely simple, simply containing functions like the following:

```ts
warn(...msg: any) {
    console.warn(...msg);
}

debug(...msg: any) {
    console.debug(...msg);
}
```

This logging service can be extended in a production environment to make it easy to share exceptions in real-time with a backend. This is useful as it allows us to "quickly triage and resolve issues [..] by providing cross-stack visibility and deep context about errors" [@Sentry].

## Components

Components are functional views written in TypeScript, HTML and CSS. All of our components are declared using the `Component` decorator. TypeScript decorators, denoted by an identifier with a leading `@` symbol, are a "special kind of declaration that can be attached to a class declaration, method, accessor, property, or parameter" [@DecoratorsTypeScript].

```ts
@Component({
    templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss'],
  selector: 'app-profile'
})
export class ProfileComponent implements OnInit {
    // ...
}
```
: Declaration of our ProfileComponent, used to display user profiles. {#lst:ProfileComponent-decl}

All components we declare only change the following attributes, an example of which is shown in [@lst:ProfileComponent-decl].

- `templateUrl` is the path to a file containing an Angular template.
- `styleUrls` is an array of paths pointing to stylesheets that can be used to style this component.
- `selector` is the custom HTML tag that can be used to display this component.

**Templates**

Angular templates are HTML files that allow users to interpolate strings, manage what HTML tags are rendered, and manage how those tags are rendered.

> "Interpolation refers to embedding expressions into marked up text. By default, interpolation uses as its delimiter the double curly braces, `{{` and `}}`." [@AngularTemplateSyntax]

This templating system can be extended by adding new:

- directives, making it possible to add new HTML attributes
- pipes, to make data transformation easier

**Styles**

CSS rules defined during component declaration only apply to that component. This has the advantage of not needing to worry about CSS rules being unique between components. Angular achieves this by using a shadow document object model (shadow DOM), described below:

> "An important aspect of web components is encapsulation — being able to keep the markup structure, style, and behavior hidden and separate from other code on the page so that different parts do not clash, and the code can be kept nice and clean." [@UsingShadowDOM]

## Dates and Times

Our API converts formats date/time objects as string _timestamps_ using the format as defined in RFC 3339. RFC 3339, "Date and Time on the Internet: Timestamps", is a specification document that "defines a date and time format for use in Internet protocols" [@DateTimeInternet].

For example, the time _4 minutes and 5 seconds past 3 PM on the 2nd of January 2006 in the timezone UTC-7_ is represented as the string `"2006-01-02T15:04:05Z07:00"`. Optionally, nanoseconds are also supported.

We could have represented dates and times as Unix time - the number of seconds since 00:00:00 UTC on 1 January 1970 - but this format is unable to represent timezones and can lose precision if the number is converted or parsed using the incorrect type.

We installed the `moment` package, a "lightweight JavaScript date library for parsing, validating, manipulating, and formatting dates" [@MomentNpm], to parse these timestamps in our frontend. This allows us to generate relative date strings such as "5 minutes ago".

To streamline our use of `moment` we also installed the `ngx-moment` package. This provided us with custom pipes which we could use inside templates, as shown in [@lst:moment-example-tgl]

```html
<span class="text-gray-light">{{ res.created_at | amTimeAgo }}</span>
```
: This is used to show the time a resource was created, relative to the user's current time. {#lst:moment-example-tgl}
