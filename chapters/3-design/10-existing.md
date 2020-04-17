# Existing software hosting websites {#sec:bg-api-analysis}

We discuss a number of the following features for each site:

- **API** Does the website have an API?
    - **Architecture.** Is the API and/or website REST-compliant? What is the URL scheme like?
    - **Use of public APIs.** Does it use its own public API?
- **Public access?** Does the API and/or website allow public access?
- **SPA.** Is the website a single page application?
- **Naming.** How does the system handle name clashes?

A single page application (SPA) is "a website whose current page is updated dynamically rather than being entirely downloaded from a server" [@PWAVsSPA]. These applications typically function by requesting data from a web API that has been built separately to the frontend.

## Npm Registry (npmjs.com)

Npm is the package manager for Node.js, which is a "JavaScript runtime built on \[Google\] Chrome's V8 JavaScript engine" [@NodeJs]. npmjs.com is a single page application built using React, which is a "JavaScript library for building user interfaces" [@ReactJavaScriptLibrary].

The website does not have a public API, so we navigated through several pages on the website and analysed the network requests that were made.

When the user visits `https://www.npmjs.com/package/leftpad` the page response simply contains an application bundle - a set of scripts - so that the web application can be rendered in-browser:

> "The page is fundamentally empty, but it includes a couple JS scripts. Once the browser downloads and parses those scripts, React will build up a picture of what the page should look like, and inject a bunch of DOM nodes to make it so. This is known as _client-side rendering_, since all the rendering happens on the client (the user's browser)." [@PerilsRehydration]

The web application retrieves JSON data by making a web request to the same url as in `window.location` (the browser's current page). When visiting `https://www.npmjs.com/package/leftpad`, to make the backend return a JSON response instead of a page containing the application bundle, the frontend sets the `X-Spiferack` header with `1` as a value. As denoted by the `X-` prefix, this header is non-standard. Additionally, the `X-Spiferack` header is not used in any open source software, so its meaning is only known to the Npm Registry developers. A semantically correct way to implement this feature would:

- have the frontend set the `Accept` header of the request to `application/json`, and
- have the web server read this header to determine whether it should respond with a JSON payload.

Packages on npmjs.com were initially only globally scoped, making packages susceptible to name conflicts. Npm version 2 introduces support for scopes, which "allows you to create a package with the same name as a package created by another user or Org without conflict". [@ScopesNpmDocumentation]

## Rust Package Registry (crates.io)

The Rust Package Registry website is a single page application that uses the Ember.js web framework^[https://emberjs.com/ - "Ember.js is a productive, battle-tested JavaScript framework for building modern web applications" (emberjs.com)]. All packages are globally scoped.

The website uses its own REST-compliant public API which is available at https://crates.io/api.

Clicking on the "rustfm" package on the search results for "lastfm" triggers several API calls, listed in [@tbl:crates-publend]. The user is presented with a "Loading..." indicator blocking the entire page when all this information is being fetched, despite the user not necessarily needing to know all this information.

| Path | Description |
|-----|-----------|
| `/` | Crate metadata, statistics, links and versions |
| `/versions` | Version metadata and stats (the same data is included above) |
| `/0.1.2/authors` | Author names and email addresses |
| `/owner_user` | Profile data for the users that own the crate |
| `/owner_team` | Profile data for the teams that own the crate |
| `/0.1.2/dependencies` | ID and versions of the crate's dependencies |
| `/downloads` | Statistics about individual download entries |

: Public endpoints on `https://crates.io/api/v1/crates/rustfm` {#tbl:crates-publend}

This pop-in effect results in poor user experience, and can be resolved in one or more of the following ways:

1. Using a single endpoint to return all the data necessary.
2. Rendering data as soon as it is available, and showing a seamless loading indicator for information that is still being fetched.
3. Lazy loading statistics - only fetching this data when the user scrolls down to the statistics section.
4. Enabling HTTP/2 for the API, so that requests can be multiplexed into a single connection.

---------------------------------------------------------------------------
Method   Path               Description
-------- ------------------ -----------------------------------------------
`DELETE` `/`                Logout the authenticated user

`GET`    `/begin`           Initiate authentication process using GitHub OAuth

`GET`    ```                Complete authentication process using GitHub OAuth,
         /authorize?        returning session information
            code=<code>&
            state=<state>
         ```

---------------------------------------------------------------------------

: Private endpoints on `https://crates.io/api/private/session` {#tbl:crates-privend}

[Table @tbl:crates-privend] shows that the only private endpoints are relating to third-party authentication. If we implement third-party authentication into our platform, we should also make it clear that those endpoints are private.

Sobers [-@WhatOAuthDefinition] says:

> "OAuth is an open-standard authorization protocol or framework that provides applications the ability for “secure designated access.” For example, you can tell Facebook that it’s OK for ESPN.com to access your profile or post updates to your timeline without having to give ESPN your Facebook password."

OAuth allows users to log into the Rust Package Registry using their GitHub credentials, without giving the Rust Package Registry their GitHub credentials.

## GitHub (github.com)

GitHub has two main APIs, REST API v3 and GraphQL API v4, and also supports push messages via "webhooks".[^GitHubAPILinks]

Their documentation describes why GitHub uses GraphQL:

> "GitHub chose GraphQL for our API v4 because it offers significantly more flexibility for our integrators. The ability to define precisely the data you want—and only the data you want—is a powerful advantage over the REST API v3 endpoints. GraphQL lets you replace multiple REST requests with a single call to fetch the data you specify." [@GitHubGraphQLAPI]

[^GitHubAPILinks]: Detailed information on these APIs can be found at https://developer.github.com/v3/, https://developer.github.com/v4/ and https://developer.github.com/webhooks/

This has clear development and performance benefits:

- we can use our own API more aggressively (the benefits of using our own API is discussed in [@sec:design-api])
- a single request can be called for all the data needed, which results in faster load times for the user
- less _contributor_ time needs to be spent creating endpoints to provide bulk data

Despite GraphQL being very powerful, we decided to build a simpler REST-compliant API. This is because GraphQL is quite difficult to set up and prototype with, especially when fleshing out a brand new API.

**Naming**

All repositories on GitHub are scoped to a user account or organisation - this means that two users can create a repository with the same name.

Their URL design follows `https://github.com{/owner}{/repo}`, replacing `{/owner}` with the username or the owner, and `{/repo}` as the repository name. This has the benefit of making it clear to all users, at a glance, who owns the repository.

We have chosen to follow a similar model in MTA Hub, as discussed in [@sec:squatting].
