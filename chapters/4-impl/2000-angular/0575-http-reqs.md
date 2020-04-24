## HTTP Requests

Our frontend needs to be able to communicate with our web API using an API that provides HTTP client functionality. There are two standard ways to make HTTP requests in JavaScript:

- The `XMLHTTPRequest` API, released by Internet Explorer 5 in 1998 [@FetchAPI], and standardised by the World Wide Web Consortium (W3C) international standards organisation in 2006 [@XMLHttpRequestObject].
- The Fetch API, defined by the Fetch Living Standard [@FetchStandard], which "provides an interface for fetching resources (including across the network)" [@FetchAPIa].

We initially chose to use Fetch's API as, compared to `XMLHTTPRequest`, it is much simpler and "provides a more powerful and flexible feature set" [@FetchAPIa]. The Angular framework, however, provides a `HttpClientModule` that can be imported from the `@angular/common/http` package, with the following additional features:

- Request interception allowing us to automatically include authentication tokens in all requests.
- Improved testing integration provided by the `@angular/common/http/testing` package.
- Typed requests and responses, "to make consuming the output easier and more obvious" [@AngularCommunicatingBackend].
- "Streamlined error handling" [@AngularCommunicatingBackend].


## `AuthInterceptor`

<!-- talk about how certain requests should still go through despite an authentication failure -->

Our `AuthInterceptor` class, a HTTP interceptor, is defined in `website/src/app/auth/auth.interceptor.ts`. Our interceptor includes the user's authentication token in all requests sent to MTA Hub's API unless the request is explicitly set to be unauthenticated.

Our `AuthInterceptor` class implements the `HttpInterceptor` class defined by the `@angular/common/http` package. The `intercept` method takes two parameters:

1. `req`, the current HTTP request. In other implementations, this request could have been modified by another interceptor, but since we define exactly one interceptor, this is the original request sent from our services.
2. `next`, the next handler, which may be another interceptor or, in our case, Angular's HTTP backend which internally performs the actual web request using the browser's `XMLHttpRequest` API.

Our `intercept` method is shown in @lst:http-interceptor and described below:

1. If the URL does not begin with MTA Hub's API base URL, as defined in the environment configuration, do not update the `HttpRequest` defined by the `req` variable.

    This security check prevents the user's authorization token being shared with unintended servers.

1. Or, if the set of request headers includes the `X-Authorization-None` key:

    (i) Create a new set with the `X-Authorization-None` header removed.
    (ii) Stored a cloned request in `req` using the new headers from (i).

    This is used on MTA Hub's homepage, which should be consistent between logged in and logged out users, so there's no need to send an authorization token. [@AllowPassingMisc]

1. Or, if the authorisation service has an authorisation token saved, stored a cloned request in `req` with the `Authorization` header set appropriately.
1. Finally, apply the `next` handler against the current value of `req`.

```ts
@Injectable()
export class AuthInterceptor implements HttpInterceptor {
  constructor(private auth: AuthService) { }

  intercept(req: HttpRequest<any>, next: HttpHandler):
                                        Observable<HttpEvent<any>> {

    if (!req.url.startsWith(environment.api.baseurl)) {
      // (1) Do nothing if url does not start with our API endpoint
    } else if (req.headers.has('X-Authorization-None')) {
      // (2) Optionally exclude authorization header
      const headers = req.headers.delete('X-Authorization-None');
      req = req.clone({ headers });
    } else if (this.auth.accessToken !== null) {
      // (3) Include authorization header if accessToken is set
      req = req.clone({
        setHeaders: {
          Authorization: `Bearer ${this.auth.accessToken}`
        }
      });
    }

    return next.handle(req); // (4)
  }
}
```
: `AuthInterceptor` from `website/src/app/auth/auth.interceptor.ts` {#lst:http-interceptor}

<!-- catching httpclient errors https://stackoverflow.com/questions/46019771/catching-errors-in-angular-httpclient -->


<!-- content-length header setting it to 0, using body:'' instead of content-length: 0 - https://stackoverflow.com/questions/7210507/ajax-post-error-refused-to-set-unsafe-header-connection/7210840 -->

<!--
### Caching

Some data rarely changes and
talk about caching techniques. for example, we can show old data initially (if available) and update with the newest info when it comes. cache eviction? disable for admin areas in case a decision is made on outdated info? make sure to still show feedback if a request fails, of course. but this would be covered by the default case. -->
