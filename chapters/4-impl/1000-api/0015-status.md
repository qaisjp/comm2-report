## Selecting HTTP status codes

HTTP status codes are a "3-digit integer result code of the attempt to understand and satisfy \[a HTTP\] request" [@HTTPStatusCode].

**401 Unauthorized vs. 403 Forbidden**

The status code `401` is means "Unauthorized", despite the code being used for _authentication_ and not _authorisation_. This means it's important to carefully selected status codes for certain scenarios.

-   401: being unauthenticated for a request that requires authentication [@HypertextTransferProtocola]
-   403: being authenticated but not authorised to perform an action [@HypertextTransferProtocola]

Okta [-@oktaAuthenticationVsAuthorization2018] describes authentication as
"the act of validating that users are who they claim to be",
and authorisation as "the process of giving the user permission to access a specific resource or function".

[@irvineUnderstanding403Forbidden2011] says:

> "Receiving a 401 response is the server telling you, 'you aren’t authenticated--either not authenticated at all or authenticated incorrectly--but please re-authenticate and try again.'"
>
> "In summary, a 401 Unauthorized response should be used for missing or bad authentication, and a 403 Forbidden response should be used afterwards, when the user is authenticated but isn’t authorized to perform the requested operation on the given resource."

<!-- Sources: (TODO)

-   https://stackoverflow.com/questions/3297048/403-forbidden-vs-401-unauthorized-http-responses
-   https://httpstatuses.com/401
-   https://httpstatuses.com/403
-   https://tools.ietf.org/html/rfc2616#section-10.4.2 -->

**Processing uploads**

When processing uploads we use the following HTTP status codes:

-

Invalid resource zip uses status code 422 - https://httpstatuses.com/422 - Status Unprocessable Entity. This is only when checkResourceZip fails for a reason
