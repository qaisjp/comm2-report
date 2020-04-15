
# Routing {#sec:routing}

Routing in Angular is provided by the `RoutingModule` in the Angular standard library.

The routing module provides many services, but the two services we used the most is:

- `ActivatedRoute`, which allows us to access information about the currently activated route
- `Router`, which allows us to manage routing in generally, so we can navigate to different sections of the website

Routing is handled alongside the primary modules we have created

preserve page info without navigation (/u/2) - initially navigating but that would cause a reload; then tried https://stackoverflow.com/a/46486677/1517394 and https://stackoverflow.com/a/39447121/1517394 ; then did https://angular.io/api/router/NavigationExtras fields to update URL without doing a full reload

Lazy loading - lazy load modules https://stackoverflow.com/a/44402953/1517394

access component outside of router-outlet. instead make a shell component that lives outside all your routes. https://stackoverflow.com/a/53023148/1517394

profile page? router route via query string https://stackoverflow.com/a/42301766/1517394

