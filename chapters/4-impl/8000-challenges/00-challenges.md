# Additional Challenges

This section describes additional technical challenges encountered during the implementation of MTA Hub.

## Setting variables in templates

Sometimes we want to set a variable inside our template instead of inside our class implementation. This can be achieved by using the `*ngFor` dynamic directive to perform a for loop through an array containing exactly one item [@HtmlHowDeclare]. We sometimes do this to avoid writing tedious code multiple times, as shown in [@lst:angular-template-forloop-one].

```html
<h1 *ngFor="let creator of [resource.authors[0]]">
    <a [routerLink]="['/u', creator.username]">
        {{ creator.username }}
    </a>
    <span class="path-divider">{{ ' / ' }}</span>
    <a [routerLink]="['/u', creator.username, resource.name]">
        {{ resource.name }}
    </a>
</h1>
```
: Performing `creator = resource.authors[0]`. {#lst:angular-template-forloop-one}

Using `*ngFor` in the way described above is also useful when want to use asynchronous data in multiple places without using the `async` pipe multiple times. The `async` pipe "subscribes to an `Observable` [..] and returns the latest value it has emitted" [@AngularAsyncPipe]. Unnecessary subscriptions to an `Observable` can cause unexpected behaviour.
