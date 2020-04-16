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

## Dates and Times



generate "ago" strings using https://www.npmjs.com/package/ngx-moment

## Templates

use ng-container https://stackoverflow.com/a/41235052/1517394 for bare if statements

template variables single assignment https://stackoverflow.com/a/40751358/1517394

