
# Resource View

use a specific service for ResourceViewService https://stackoverflow.com/a/41451466/1517394

now only owners have access to serious admin operations, which is an improvement over everyone having equal access. this is much more important now that resources are namespaced under their creators username.


# Resource Frontend

## About

The About page is managed by the

### Rich Text

In the existing system, scripters can only insert plain text into their resource description. This makes it difficult for them to market their resource as scripters are unable to format text, include links, lists or embed images. To solve this issue we chose to render the resource description as Markdown.

Markdown is an "easy-to-read, easy-to-write plain text format" [@DaringFireballMarkdown] supported by most software-hosting websites, including the websites we analysed in [@sec:bg-api-analysis]: Npm Registry, Rust Package Registry and GitHub.

Resource descriptions are stored in plaintext in database using the `text` SQL type and rendered on the frontend using the `ngx-markdown` package^[ngx-markdown package: https://www.npmjs.com/package/ngx-markdown].
