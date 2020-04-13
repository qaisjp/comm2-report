\chapter{Evaluation}

# Testing

The technologies used in this project were carefully chosen to support automated testing. The backend supports testing via Go's inbuilt testing infrastructure (`go test`). Every component on the frontend has a test file,  automatically generated via the `ng generate` command, ready for manual expansion by contributors.

# Stakeholders

**Administrators and Moderators**

Both these stakeholders currently have equal access across the entire system, and have implicit "owner" status over every resource. This means they can see all resources, public and private.

Further work to be done here includes:

- limiting permanent destructive operations to administrators
- implementing a warning and ban system
- introducing a resource approval process

**System administrator (sysadmin)**

Sysadmins can quickly deploy the website using Docker and database migrations can easily be applied via the command line.

**Contributors**

Contributors can quickly deploy a local version of the website using Docker.

Database migrations can easily be applied but if multiple contributors submit pull requests, a conflict will arise that needs to be handled manually. This may not be in the form of a _Git_ merge conflict, meaning that extra care needs to be taken when reviewing pull requests. This problem could be solved via a GitHub Action.

The backend follows Go's conventions including established commenting practices, meaning that the `go doc` tool can be used to quickly generate documentation from the code. Since the code will be open source, any contributor would be able to access this documentation online via the `godoc.org` service.

The frontend follows a standard directory structure and supports Angular's `ng` command line tool, so it is easy to generate new modules, components, services and directives.

**Scripter**

Scripters have the ability to upload resources, add authors without giving them full access, manage resource settings, and provide rich text media in the resource description.

**Server owner**

Servers owners have the ability to "Follow" authors, but this currently does not have any useful effect.

Servers owners are able to create special accounts for their server and host their private resources on the website, and add their developers as collaborators. However, they would benefit from an additional "resource lists" feature, so that other users' resources can be included in their personal lists.

This would behave similar to a playlist on YouTube, where lists could be made private, unlisted or public; and private resources in the list would be hidden from those who do not have read access, but public resources in the list _would_ still be accessible. In the future, servers could automatically sync resources from these lists.


# User Experience

MTA Hub includes many quality of life improvements, making it more pleasing to use than the existing system.

Every page of MTA Hub is built mobile-first, is responsive, and supports all screen sizes. The existing system, however, does not have any responsive pages and only supports a large desktop screen size.

MTA Hub has improved accessibility and achieves this by using `aria-*` attributes wherever necessary. The existing system does not take into account accessibility at all.


# Performance

MTA Hub outperforms the existing system in all aspects.

Due to the use of a more efficient database schema, supported by the proper use of table indexing and other advanced features offered by PostgreSQL, most SQL queries have sped up compared to a local PHP instance of the existing system.

The use of a statically compiled binary in our API, compared to the interpreted nature of PHP, has improved runtime performance.

TODO: actual numbers, graphs

# User Testing

Due to the COVID-19 crisis we were unable to perform valuable in-person user testing.
