\chapter{Implementation}

# Authentication

Authentication is implemented as a middleware.

Initially we had two middleware functions:

-   `authRequired` - this is returned by the JWT library
    (`authMiddleware.MiddlewareFunc()`). Any route that includes this
    middleware function requires the request to have an authenticated
    user.
-   `authMaybeRequired` - this is a function we've created that, if an
    auth token is provided, verifies the user (via `authRequired`), and
    otherwise sets the `user` context variable to `nil`.

This works well when `authMaybeRequired` isn't used frequently, but we
soon discovered that a lot of our routes included this. Some entities ---
resources, packages & gallery items --- may be in a state that means that
they should only be accessible to resource managers and site admins.

We decided to change to three middleware functions:

-   `authMiddlewareFunc` - this is returned by the JWT library
    via `authMiddleware.MiddlewareFunc()`, as `authRequired` above
-   `authMaybeRequired` - this is the same as above except it verifies
    the user via `authMiddlewareFunc`

-   `authRequired` - this is a function we've created that, if the
    `user` context variable is `nil`, will abort, and send a response
    containing:

    -   the header `*WWW-Authenticate` to `JWT realm=multitheftauto.com`,
    -   the status code to `401 Status Unauthorized`, and
    -   the body `{"message": "You must be logged in to perform that operation."}`

All authenticated administrators should be able to access the following entities:

-   resources - unpublished resources, suspended resources
-   packages - draft packages
