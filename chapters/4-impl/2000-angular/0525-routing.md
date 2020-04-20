## Routing {#sec:routing}

Routing in Angular is provided by the `RoutingModule` in the Angular standard library. This helped us make MTA Hub a single-page application by:

- determining what components are rendered on-screen,
- updating the URL shown in the browser's address bar, and
- providing a way to access navigation data

The routing module provides many Angular services, but the two services we used the most is:

- `ActivatedRoute`, which allows us to access information about the currently activated route
- `Router`, which allows us to manage routing in generally, so we can navigate to different sections of the website

**Lazy loading**

Lazy loading - lazy load modules https://stackoverflow.com/a/44402953/1517394


**Navigating without reloading**

A user's profile URL is `/u/` followed by their username, for example `/u/alice`. Our API, however, supports querying a user by just using their ID. This if `alice` had the ID `2`, our users could access `alice`'s profile by visiting `/u/2`. This ID is not user friendly and we would like our users to know what page they are on just by looking at the URL. This section describes how implemented a redirector from `/u/2` to `/u/alice`.

Our initial implementation [@JavascriptChangeRoute] is described below:

```{=latex}
\begin{enumerate}[{Line} 1:]
\item Subscribe to URL parameters updates
\item Fetch the user profile that corresponds to the `username` URL parameter. Note that the username given in the URL parameters may actually be a user ID.
\stepcounter{enumi}
\item Check the retreived username is different to the username given in the URL parameters.
\item Use `window.location.pathname` to navigate to the canonical user profile URL.
\end{enumerate}
```

```typescript
1 this.route.params.subscribe(params => {
2   this.users.getUserProfile(params.username).subscribe(data => {
3     // Update url from ID to username if necessary
4     if (data.username !== params.username) {
5       window.location.pathname = "/u/" + data.username;
6     }
7 // ...
```
: Initial implementation using `window.location.pathname`. {#lst:routing-redirect-1}

This solution, shown in [@lst:routing-redirect-1], is jarring and slow because updating `window.location.pathname` results in a full page reload. Additionally it results in an extra history entry, resulting in poor user experience as the user's browser Back button will perform in an unexpected way.

As shown in [@lst:routing-redirect-2], this was resolved by importing `Location` from the `@angular/common` package and using the `replaceState()` function. This function "changes the browser's URL to a normalized version of the given URL, and replaces the top item on the platform's history stack" [@AngularLocationReplaceState].

```typescript
 5       this.location.replaceState("/u/" + data.username);
```
: Second implementation, using `this.location.replaceState`. {#lst:routing-redirect-2}

Navigating to a new page in this way results in screen flicker and additional HTTP requests. as shown in [@lst:routing-redirect-final], this is resolved by using the `navigate` function of the `Router` service from `@angular/router`, with the following options [@AngularNavigationExtras]:

```{=latex}
\begin{enumerate}[{Line} 1:]
\setcounter{enumi}{6}
\item Preserve the URL fragment - this is the \texttt{\#section} that can appear at the end of the URL.
\item Preserve query parameters in the URL - this is anything that appears after \texttt{?} and before the URL fragment.
\item Replace the URL state to prevent additional requests and an extra history entry.
\end{enumerate}
```

```typescript
 1 this.route.params.subscribe(params => {
 2   this.users.getUserProfile(params.username).subscribe(data => {
 3     // Update url from ID to username if necessary
 4     // without causing a page reload
 5     if (data.username !== params.username) {
 6       this.router.navigate(['u', data.username], {
 7         preserveFragment: true,
 8         queryParamsHandling: 'preserve',
 9         replaceUrl: true,
10       });
11     }
12 // ...
```
: Final implementation using `this.router.navigate`. {#lst:routing-redirect-final}
