# HTTP Requests

interceptors - https://angular.io/guide/http#http-interceptors

talk about how certain requests should still go through despite an authentication failure

interceptor - X-Authorization-None hack https://github.com/angular/angular/issues/18155#issuecomment-342155391 talk about using "X"


interceptor - ensure url starts with our API endpoint. security. don't send authorization header to all servers lol

catching httpclient errors https://stackoverflow.com/questions/46019771/catching-errors-in-angular-httpclient


content-length header setting it to 0, using body:'' instead of content-length: 0 - https://stackoverflow.com/questions/7210507/ajax-post-error-refused-to-set-unsafe-header-connection/7210840


## Caching

Some data rarely changes and
talk about caching techniques. for example, we can show old data initially (if available) and update with the newest info when it comes. cache eviction? disable for admin areas in case a decision is made on outdated info? make sure to still show feedback if a request fails, of course. but this would be covered by the default case.

## HTTP Stuff, again

Hyphens - The standard best practice for REST APIs is to have a hyphen, not camelcase or underscores. - This comes from Mark Masse's "REST API Design Rulebook" from Oreilly.

Invalid resource zip uses status code 422 - https://httpstatuses.com/422 - Status Unprocessable Entity. This is only when checkResourceZip fails for a reason



## Downloads

listening to upload/download progress events https://angular.io/guide/http#listening-to-progress-events

## Uploads

File uplaods - https://medium.com/@amcdnl/file-uploads-with-angular-reactive-forms-960fd0b34cb5,  - https://www.techiediaries.com/angular-formdata/
