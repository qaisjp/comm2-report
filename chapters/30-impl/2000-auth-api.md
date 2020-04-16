# API Design {#sec:design-api}

Our web application uses its own _public_ API (rooted at `/v1/`) wherever possible (this is known as "dogfooding"), but we predict that
certain pages may take a while to load if multiple requests are involved. One example of such a page would be a user's profile, where
one request would be `/v1/users?username=qaisjp&exact=1` to find the user by username and get their user information and
then `/v1/users/1/resources` to list their resources.

In response to whether a website should use its own public API:

- Evers says that one "should not be updating the API frequently", that they should "spend the time to architect and proof out an API that will stay around for a while" and that "dogfooding in this way will enforce [this]" [-@eversShouldWebsiteUse2012].
- Dante says "Unless the performance overhead of using the web service is an issue, you should definitely use your public API. This will help you get a consistent behavior between your application and the consumers. It will also avoid code duplication [...]" [@danteArchitectureHowMy2013]

Based on this, we have chosen to also make use of _private_ internal endpoints. This will allow us to
"make data access more performant by using the database directly instead of doing extra requests" [@virkkunenApiDesignIt2010].
These internal endpoints live at `/private/` instead of the regular `/v1/` prefix, discouraging those that reverse engineer our webapp from building
software using these endpoints.

<!-- other links: TODO
- https://softwareengineering.stackexchange.com/questions/332864/fully-api-based-website-is-it-a-good-idea -->

## Permission management

We decided that permissions will be granular for site administrators,
but kept simple on a resource level. Original creators of a resource retain
permanent access rights to a resource and can also designate additional resource
administrators. These designated resource admins have all the same
permissions as the creator.

TODO: why?

## Deletions

A common approach to deleting entities in webapps is
to set an `is_deleted` flag to `true` and simply hide the row from
output.

This is useful if we need to maintain an audit log or (considering that
deletions are destructive) would like to undo changes.

Users, however, may not appreciate a website holding onto data they've
requested to be deleted.

When deleting _resources_ we can just run an SQL query like `delete from resources where resource_id = ?`
and let PostgreSQL cascade this via foreign keys.

Doing this for users raises the following questions:

1. When the user requests a deletion, their comments should be anonymised instead of outright removed (todo: why?)
2. When an admin deletes the account, the admin should decide whether or not their comments should be removed too. This allows admins to easily purge content from spammers.
3. What if an admin  post-comment-retaining-deletion, that
    their posts should have indeed been deleted?

(TODO) Deletions could:

- For comments and bans, allow `author_id` to be nullable. Show `[deleted]` in place.
    - This means we lose track of who the author was.
    - Reddit does this.
- When deleting user accounts, delete all the associated data, but keep the user row, and set `is_deleted` to true. We should also remove all personal data.
    - We also need to litter `if user.is_deleted then` everywhere

This is in line with the General Data Protection Regulation (GDPR) as only personally identifiable information needs to be removed. Comments do not contain sensitive data, and do not fall under the GDPR.

## Error handling

In initial experiments all errors were returned to the user — even internal errors. This is considered "leaky" (TODO: be more formal, don't say "leaky". You can quote https://cwe.mitre.org/data/definitions/209.html.) The API should instead always return the `http.StatusInternalServerError` server code and use logging facilities to output the error.

TODO: is it OK to say "in initial experiments" during the design phase?

Services like Sentry can also be used to keep track of production errors.

## Selecting HTTP status codes

### 401 Unauthorized vs. 403 Forbidden

The status text for *401* is *"401 Unauthorized"*, despite it being for _authentication_ and not _authorisation_.
This means it's important to carefully selected status codes for certain scenarios.

-   401: being unauthenticated for a request that requires authentication
-   403: being authenticated but not authorised to perform an action

Okta [-@oktaAuthenticationVsAuthorization2018] describes authentication as
"the act of validating that users are who they claim to be",
and authorisation as "the process of giving the user permission to access a specific resource or function".

[@irvineUnderstanding403Forbidden2011] says:

> [..] Receiving a 401 response is the server telling you, “you aren’t authenticated--either not authenticated at all or authenticated incorrectly--but please reauthenticate and try again.” [..]
>
> In summary, a 401 Unauthorized response should be used for missing or bad authentication, and a 403 Forbidden response should be used afterwards, when the user is authenticated but isn’t authorized to perform the requested operation on the given resource. [..]

Sources: (TODO CITEME)

-   https://stackoverflow.com/questions/3297048/403-forbidden-vs-401-unauthorized-http-responses
-   https://httpstatuses.com/401
-   https://httpstatuses.com/403
-   https://tools.ietf.org/html/rfc2616#section-10.4.2
