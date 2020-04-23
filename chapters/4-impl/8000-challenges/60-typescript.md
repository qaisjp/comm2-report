## TypeScript Challenges

#### Global variables

One problem we encountered was the accidental access of global variables. The browser sets a number of default global variables - `name`, `window`, and more. We expected using the `name` variable, in a context where it was not defined, to result in a compile-time error, but instead it resulted in a runtime error! To resolve this we set the `no-restricted-globals` setting in our TypeScript linting configuration, which provides the following feature:

> "Disallow specific global variables. Disallowing usage of specific global variables can be useful if you want to allow a set of global variables by enabling an environment, but still want to disallow some of those." [@RuleNorestrictedglobals]

#### Composing Types {#sec:composed-types}

: Fields readable by all users {#lst:typf-User}
```ts
export interface User {
  readonly id: number;
  readonly created_at: string;
  readonly username: string;
  readonly gravatar: string;
  readonly level: number;

  readonly follows_you?: boolean;
}
```

: Fields only available to the currently authenticated user {#lst:typf-AuthenticatedUser}
```ts
export interface AuthenticatedUser extends User {
  readonly updated_at: string;
  // in the future, more fields
}
```

: Interfaces relating to a user's _profile_ {#lst:typf-UserProfile}
```ts
export interface UserProfileData {
  bio: string;
  location: string;
  organisation: string;
  website: string;
}

export interface UserProfile extends User, UserProfileData {
  readonly resources: Resource[];
  readonly following: User[];
  readonly followers: User[];
}
```


In our code we did not want to explicitly write multiple similar type declarations as this would make it difficult to change the types of our structures later on. To get around this problem we made use of TypeScript's type composition features.

In [@lst:typf-User] we declare a User interface with several _public_ fields that the world is allowed to view about every user. Since the authenticated user ([@lst:typf-AuthenticatedUser]) would be able to see at _least_ these fields, we made sure to use `extends` so that we only provided the additional fields available to `AuthenticatedUser`.

Most API responses that return entities relating to users return the User interface ([@lst:typf-User]). The API response for the user profile page, however, contains additional user _profile_ data, such as the user's bio -- this additional data is represented by the `UserProfileData` interface [@lst:typf-UserProfile].

This interface is used when both modifying the data and also reading the data, so `UserProfileData` does not extend `User` directly. For the user profile response we created an additional `UserProfile` interface [@lst:typf-UserProfile] that extends _both_ `User` and `UserProfileData`. This interface also includes extra information such as the user's list of resources, and public information about the people that the user _follows_ or is _followed by_.

In [@lst:typf-ResDerived] we build other types using TypeScript's type transformation utilities:

- `ResourceCreateResponse` takes the `Resource` type [@lst:typf-Resource], picks only the `id` property, and constructs a new type with all the properties of the resultant object as read-only.

    **Declaration**

    ```ts
    export type ResourceCreateResponse = Readonly<Pick<Resource, 'id'>>;
    ```

    **Effective type**

    ```ts
    export interface ResourceCreateResponse {
        readonly id: number;
    }
    ```
- `ResourcePatchRequest` takes a number of properties from `Resource`, then makes them _optional_. Optional properties are denoted by a question mark:

    **Declaration**

    ```ts
    export type ResourcePatchRequest = Partial<
	Pick<Resource,
		'name' | 'title' | 'description' | 'visibility' | 'archived'
    >>;
    ```

    **Effective type**

    ```ts
    export interface Resource {
        name?: string;
        title?: string;
        description?: string;
        visibility?: ResourceVisibility;
    }
    ```
- `ResourceID` allows a type to be either the type of the `id` field or the `name` field, of the `Resource` interface.

    **Declaration**

    ```ts
    export type ResourceID = Resource['id'] | Resource['name'];
    ```

    **Effective type**

    ```ts
    export type ResourceID = number | string
    ```

#### Destructuring Objects

This section explores a challenge we had in extracting variables from objects using TypeScript's destructuring syntax.

Declaring extra types that are only being used once is wasteful -- in a number of lambda functions we only want a single field of a single parameter -- we can use destructuring to avoid unnecessary declarations.

Take the following example:

```ts
data = {
    pkg: { ... } // a ResourcePackage
};

l(data); // `l` is some lambda function
```

Inside our lambda function `l`, to access `pkg`, one might write the following code:

```ts
l(data): {
    let pkg: ResourcePackage = data.pkg;
    // we never touch the `data` object again...
    // use `pkg` here
}
```

We want to write more concise code, so we take advantage of TypeScript's support for object _destructuring_:

```ts
l({ pkg }) {
    // `data` is not defined, so we can't use it...
    // use `pkg` here
}
```

However, this `pkg` variable doesn't actually have the type `ResourcePackage`, it has the `any` type, allowing it to be used in place of _any_ type. To fix this, we initially included a type annotation for the `pkg` variable, like so:

```ts
l({ pkg: ResourcePackage }) {
    // error?!
}
```

However, this code _doesn't_ destructure an object, pluck `pkg`, and give `pkg` the type `ResourcePackage`. It actually plucks a `ResourcePackage` attribute, which is in our case non-existent, and names that variable as `pkg`.

The solution we found, with the assistance of Schulz [-@TypingDestructuredObject], was to first provide the type of `data` -- `(data: { pkg: ResourcePackage })` -- and _then_ destructure it, like so:

```ts
l({ pkg } : { pkg: ResourcePackage }) {
    // use `pkg` here
}
```

#### Manually Creating an Object That Satisfies an Interface

In our `ProfileComponent` we created a field called `form`:

```ts
form: FormGroup = this.formBuilder.group({
    bio: '',
    location: '',
    organisation: '',
    website: '',
} as UserProfileData);
```

In TypeScript it is not possible to create a new object with default 'zero' values of an interface. We must explicitly create an object with all the fields we want, with zero values.

To prevent bugs, it is important for our code to raise a compile-time error if we changed the declaration of `UserProfileData`. However, we discovered that this code would not cause an error because the ` as ` keyword converts an object of type `any` into the type on the right hand side.

We discovered that in a previous version of TypeScript `<UserProfileData> { ... }` was a type _assertion_ - asserting that a given object was of the type `UserProfileData`, without actually checking the object. In that same version, using `{ ... } as UserProfileData` would throw a compile-time error as the types do not match.

In later versions, TypeScript had to remove the `<T> x` syntax as it clashed with a JavaScript extension called "JSX", which allows programmers to write HTML inside JavaScript code. To provide the same type assertion feature, the TypeScript developers weakened the ` as ` keyword, no longer making it possible to write an object, declare _and_ check its type at the same time [@HowCanCreate].

We discovered a workaround - if we declare a variable "first", and _then_ assign an object to it, TypeScript will raise a compile time error. At the top of our file we wrote the following code:

```ts
const zeroUserProfileData: UserProfileData = {
    bio: '',
    location: '',
    organisation: '',
    website: '',
};
```

Note that objects in JavaScript (and TypeScript) are pass-by-reference, so to prevent bugs we performed a shallow copy when using our `zeroUserProfileData` object:

```ts
form: FormGroup = this.formBuilder.group({...zeroUserProfileData});
```

If we did not do this, future recreations of the component would have stale data as the default, rather than zero values.
