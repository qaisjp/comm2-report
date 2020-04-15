# Profile Pictures

Profile pictures should be displayed prominently in places where a user's username is shown. To provide this feature we depend on the _Gravatar_ web service. Gravatar stands for "Globally Recognized Avatars" and "is an image that follows you from site to site appearing beside your name when you do things like comment or post on a blog" [@GravatarGloballyRecognized].

We chose to use Gravatar as it provides an easy way for us to implement this feature, and is consistent with the rest of our web services - which also use Gravatar. We derived the user's Gravatar using the code shown below:

```go
1 gravatar := fmt.Sprintf(
2     "https://www.gravatar.com/avatar/%x",
3     md5.Sum([]byte(
4         strings.ToLower(
5             strings.TrimSpace(u.Email),
6         ),
7     ),
8 ))
```

The lines above are described by the following:

- Line 5: first we trim spaces from the front and back of the user email address.
- Line 4: we convert that string to lowercase.
- Line 3: since our input is a _string_, we use the `[]byte(..)` function to return a copy of the string's underlying byte array (a `[]byte`). We can then use the `Sum` function from the `md5` library to generate an MD5 checksum from our array of bytes, returning another array of bytes.
- Line 2: the `%x` _verb_ in our _format string_ encodes a `[]byte` using "base 16, lower-case, [with] two characters per byte"[@FmtGoProgramming].
- Line 1: we use the `Sprintf` function from the `fmt` (pronounced _format_) to generate a _string_ based on a _format string_.

Gravatar does not come without privacy implications, though. One could "generate a list of email addresses and compute the corresponding md5 hash [and then] look for collisions in your list of gravatars"[@GravatarsWhyPublishing] -- this is known as a **rainbow table** attack.

To combat this problem, before the final public release we plan to introduce a setting that allows the user to disable this feature.

In our initial implementation we used the ngx-gravatar^[https://www.npmjs.com/package/ngx-gravatar] package to provide the `ngxGravatar` _directive_. As shown below, we could provide the `[email]` attribute to display a user's profile picture at a specific size.

```html
<img ngxGravatar [email]="'alice@example.com'" size="30">
```

We realised that this would reveal email addresses to all users of the website, and so now we generate the Gravatar URLs server-side and display the image using simple `img` tags, as shown below:

```html
<img [src]="user.gravatar + '?size=150'">
```

In the future we could also implement our own `ngxGravatar` directive to add support for the `size` attribute. This would:

- Allow us to accept either a Gravatar hash or, if the user has disabled Gravatar, a URL.
- Increase modularity by allowing us to handle avatar sizing in a separate module without duplicating this logic everywhere, abiding by the _DRY_ software design principle - "Don't Repeat Yourself".
