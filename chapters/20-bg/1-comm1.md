\chapter{Background}

The existing platform^[https://community.mtasa.com] was written for the MTA community in 2006 by Stanislav Bobrov and other contributors.

# Navigation

All pages on the website, in terms of visual design, follow a consistent template:

- country flags to change translation, when clicked, change the interface's language for the remainder of the active PHP session
- a sidebar
- the top navigation icons
    - when logged out, has links to the "Home", "Register", "Login" and "Resources" pages, and an external link to the game's forum
- three top navigation icons "groups", "resources" and "servers"; leading to their respective pages on the platform
- a navigation bar
    - when logged out: has links to "Register" and "Login"
    - when logged in, links to:
        - the user's profile ("My View")
        - the admin panel, if they are an administrator ("Admin Panel":)
        - an external download page ("Download MTA:SA")
        - the logout page ("Logout (foo)", with "foo" replaced with the user's username)

The index.php script generates all pages on the website. `GET` parameters in the query string indicate the active page, as shown in the deconstruction of the following URL.

`/index.php?p=stats&show=vehicles&id=254572`:

- `p=stats`: statistics page
- `show=vehicle`: show vehicle submodule
- `id=254572`: show statistics for a user with ID 254572

The `p` parameter describes the top-level module and each module tends to handle submodules in its own way.

The existing platform originally included support for groups, resources and servers; but today we only use the resources feature. This project does not aim to recreate the groups or servers feature of the website.

# Translation

The existing system includes support for many different languages, making the website very accessible to the international MTA community.

![Flags that behave as buttons at the top of each page](chapters/20-bg/assets/comm1-flags.png){#fig:comm1-flags}

Clicking one of the links in [@fig:comm1-flags] will switch standard parts the user interface to the language that the user has selected. On the home page, this currently changes the language of:

- the sidebar links
- some navigation bar links (excluding "Admin Panel" and "Download MTA:SA")
- NOT the top navigation icons
- NOT the website description and headers

The language selected is saved for the duration of the PHP session, which lasts until the browser is closed or the user's IP address has changed.

**Implementation and Security**

Each flag is a hyperlink reference to the current page with the `set_lang` GET parameter appended. For example, if the user clicks on the German flag when on the resource listing page (`?p=resource`), they will be directed to the `?p=resources&set_lang=de` page.

On receipt of the `set_lang` GET parameter, the backend immediately saves the language in the PHP session, via the `$_SESSION` dictionary. This parameter is used directly in file inclusion without sanitisation, making it an attack vector, as per CWE-22 [@CWE22ImproperLimitation].

Each language file is a PHP script that adds strings sequentially to an array, as shown below:

```php
<?
// Main
$text_item[1] = 'My View';
$text_item[2] = 'Register';
$text_item[3] = 'Login';
$text_item[4] = 'Logout'; // [...]

// Auth [...]
$text_item[32] = 'Username';
$text_item[33] = 'Password';
$text_item[34] = 'Forgot your password?'; // [...]

// Profile
$text_item[51] = 'My view'; // [...]
```

This is prone to errors and results in a poor user and contributor experience:

- a typographical error can result in the wrong text being shown to users, or even a page failing to load due to script error.
- translation effort can be duplicated, as shown in text item 1 and 51 above
- a contributor building the website will not have a clear idea of what text is being shown.
- internationalisation concepts such as pluralisation, number formatting, and date formatting is unsupported.

# Homepage (`?p=main`)

!["Latest resources" section on the homepage](chapters/20-bg/assets/comm1-resources.png){#fig:comm1-resources}

As shown in [Figure @fig:comm1-resources], the homepage contains a short description of what the system is for and also a link to the resources page titled "Latest resources". There is also a preview of the 100 most recently uploaded resources underneath. Only resources that fit the following criteria are be shown:

- must be 'active' (not 'suspended' or 'pending')
- must have pictures in the gallery

At the bottom of the page there are also pagination buttons. These pagination buttons simply submit a form that refreshes the page and simultaneously incrementing or decrementing the `oset` query string parameter by 100.

If the `oset` query parameter is `0` (or missing, as it is when you initially visit the page),
no pagination buttons are shown and only a single "MORE.." button is shown. The `oset` parameter is not capped, and can go as far as the earliest resource that fits the above criteria.

If the `oset` parameter goes beyond the number of potentially viewable results, no resources will be shown, and the pagination
buttons will still be enabled. This is considered to be poor user experience (UX) as a user may not know that they have reached the end of the list, and may attempt
to keep clicking "Next" in the attempt to show more items. Currently a user is presented seventy pages, and in practice, a user most likely will not click through all those pages of pictures, so this pagination feature can be considered unnecessary.

# Resources (`?p=resources`)

This page has several headings:

- Upload resource
- Filter options
- Top Downloads
- Top rated Resources
- Recently uploaded Resources

**Upload new resource**

![Primary resource upload interface](chapters/20-bg/assets/comm1-pkg-upload-2.png){#fig:comm1-pkg-upload}

Underneath the "Upload resource" heading is a singular "Upload!" link. When the user clicks this link, if they are not logged in, they are shown a login panel with a username and password field.

If the user is logged in, they are shown the interface in [@fig:comm1-pkg-upload].


This same flow is followed for both uploading brand new resources and updating existing resources. This has several user experience repercussions:

- It is not clear that this upload interface is how you update existing resources. This has been a common question to support staff in the past.
- The existing description should be shown for existing resources, allowing the user to quickly make minor tweaks. Current users find copying-and-pasting the old description too inconvenient and error-prone.
- The `changelog` field should not be shown if the user is creating a brand new resource.
- Accidental changes to the description can cause distress to the user as previous descriptions are not recoverable.
- In case of an upload error or clash in resource name, the user will lose the text they have submitted.

**Filter options**

![Searching resources for "handling editor" in the description](chapters/20-bg/assets/comm1-search.png){#fig:comm1-search}

This section contains three input fields allowing the user to filter by name, description, or type. The `type` field is a dropdown consisting of the four allowed resources types listed in [@sec:terminology] Terminology.

Pressing the search button will send a POST request to the same page with the search query sent via the submitted form. As shown in [@fig:comm1-search], the search results page has:

- the "Upload resource" header
- the "Filter options" header
- a list of search results in a table

This page has several UX problems:

- there is no need to show the Upload resource section - this wastes vital vertical space
- input fields are cleared, requiring the user to manually type their query again
- Because this is a POST request, clicking on a resource and then pressing the back button will result in a browser popup asking the user if they would like to resend the search query request.
    1. There is no need to show the popup as the user will always want to see the search results again.
    1. The user may become confused and choose to cancel the operation.

Additionally, using the `POST` method in the HTTP request here is unnecessary as no data is being changed. This violates representational state transfer (REST) principles. REST-compliant web services provide "uniform interface semantics -- essentially create, retrieve, update and delete -- rather than arbitrary or application-specific interfaces" [@WebServicesArchitecture].  This is a software architectural style shared by all production-grade APIs.

**"Top Downloads"**

This section shows 15 unsuspended resources, ordered by the `download_count` column in descending order.

This section is quite useful to new users that are server owners - it gives them an idea of the most popular resources since the beginning of the platform. These resources are often quite mature and are easy for server owners to install. However, download count is not an accurate metric for quality, and can simply reflect the community's historical interest in the resource.

This section is _not_ useful to returning users as the section changes infrequently. This is because long-standing resources are likely to accumulate many downloads over a long period of time - it is unlikely for a new resource to legitimately accumulate more downloads than a resource that was created over ten years ago.

**"Top rated Resources"**

This section shows 15 unsuspended resources with at least ten votes, ordered by the `rating` column in descending order.

The "Top rated Resources" section attempts to increase effectiveness and prevent abuse by limiting list entries to resources with at least ten votes, but this is still ineffective as the rating system does not take into account the number of votes. The current system will score a resource with six 5-star votes _higher_ than a resource with one hundred 5-star votes and two 1-star votes.

One benefit of the current rating system is that this section is always kept "fresh", despite being inaccurate.

**"Recently uploaded Resources"**

This section simply lists the resources of the 15 most recent unsuspended packages. This section is not very useful for resource discovery and is susceptible to abuse as a user can upload many packages in succession to flood this list with just their resource.

# Authentication

The authentication process has several UX problems:

- Entering incorrect credentials when logging in will present the user with an error "Invalid user id", rather than a "Invalid username/password" message.
- Errors during registration shows duplicate "Username already exists" warnings and does not visually stand out, as shown in [@fig:comm1-registration-error].

    ![A warning is shown twice and does not stand out.](chapters/20-bg/assets/comm1-registration-error.png){#fig:comm1-registration-error}

- The logout landing page shows links in the navigation bar that should only be shown to logged in users, as shown in [@fig:comm1-logout]. This is can confuse t he user into thinking that the logout process failed.

    ![The navigation bar shows incorrect links on the logout page.](chapters/20-bg/assets/comm1-logout.png){#fig:comm1-logout}

- The logout landing page only shows for one second before redirecting to the homepage. This is unexpected — according to [@InteractionDesignRedirect] "if there is text on a redirect screen give the user enough time to engage with the concept of the content, regardless of the time it takes to redirect".

# Individual Resources (`?p=resources&s=details`)

Individual resource pages are split into four main sections:

- the header,
- the description,
- calls to action, and
- version history

**Heading**

![The header of the "hedit" resource](chapters/20-bg/assets/comm1-hedit-header.png){#fig:comm1-hedit-header}

UX issues here include:

- The creator of this resource is the user name `Remi-X`, but this isn't clear.
- If the user is logged out, instead of saying "You need to be logged in to vote", the `Rate` row should either:
    - be hidden if the user is not logged in
    - be shown, but prompt for a login when a vote button is clicked
- If the user is logged in and they are an author, the `Rate` row is hidden. This can confuse the author if they would like to tell other users how to vote on their resource. Instead, the vote buttons should be shown, but _disabled_ with a tooltip saying "You cannot vote on your own resource".
- If the user is logged in, not an author, and has already voted - as shown in [@fig:comm1-vote-already], there should not be a message reminding the user that they can change their vote. The message is unnecessary as the other vote buttons are still clickable and are not disabled.

![Voting when the user is logged in, not an author, and has already voted.](chapters/20-bg/assets/comm1-vote-already.png){#fig:comm1-vote-already}

**Description**

The description field does not support the embedding of rich media or other formatting. To improve user experience, MTA Hub could explore allowing users to insert rich text either through HTMl or Markdown.

Links inserted in the description are currently broken due to poor HTML escaping. This is also susceptible to Cross-Site Scripting (XSS) attacks, which can allow an attacker to "transfer private information, such as cookies that may include session information, from the victim's machine to the attacker", as per CWE-79 [@CWE79ImproperNeutralization].

**Calls to action**

Table [-@tbl:comm1-rescalls] shows that there are two links available to non-authors (or logged out users) and three available to elevated users (site admins or resource authors).

| Link name               | Elevated? |
|-------------------------|-----------|
| Download latest version | No        |
|         Upload pictures | Yes       |
|           Edit resource | Yes       |
|            Resource log | Yes       |
|                  Report | No        |

: All possible calls to action on a resource {#tbl:comm1-rescalls}

The edit resource page allows the user to:

- edit the description
- delete previous versions
- add or remove authors
- delete the resource (if admin)
- suspend the resource (if admin)

Resources do not have a concept of "creators" and "collaborators", only "authors", and this means that the add or remove authors feature has serious security implications. All authors have equal permissions, meaning that a resource can be hijacked and stolen from its creator by a rogue collaborator. This is a security vulnerability we should resolve in MTA Hub.

Authors should also be able to delete their own resources, especially since they are already permitted to delete all resource packages. One possible reason that this feature was gated to administrators only is to prevent malicious resource authors quickly name-squatting a resource after it has been deleted.

**Version History**

This section is a table with at least four columns: "Version", "Publish Date", "Changes" and "Download".

This list can be very long and most users are only interested in the most recent updates, or updates since the last visit. To improve user experience, we could:

- show a "see more" button to expand the list of versions shown, if many versions have been uploaded
- track what resources the user downloads, and highlight versions that have been published since the user downloaded the resource

For administrators, an additional "Contents" link is shown. This leads to a page that shows the `meta.xml` file of the resource and the contents of each script that has been included. If the script is compiled, the backend will decompile the script and present the administrator with the decompiled version of the script, for auditing purposes.

To improve user experience, we should present a list of scripts names in the form of hyperlinks, instead of requiring the user to scroll through the entire page. Additionally, the user should be able to collapse individual scripts that have been reviewed.

We should also make this "Contents" feature available to all users, and not just administrators. Only administrators would be able to access the decompilation feature. Since opening large zip files in memory can put unnecessary stress on our backend, we should support client-side downloading and unpacking.
