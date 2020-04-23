\blandscape
\chapter*{Appendix B: API Endpoints}
\stepcounter{chapter}
\markboth{Appendix B: API Endpoints}{Appendix B: API Endpoints}
\addcontentsline{toc}{chapter}{Appendix B: API Endpoints}


| Method | Path                    | Description
|--------|-------------------------|-----------|
| GET    | /homepage               | Get resources to be displayed on the homepage |
| GET    | /profile/:user_id       | Get a user's profile page information |
| DELETE | /account                | Delete the current user's account |
| POST   | /account/username       | Change the current user's username |
| POST   | /account/password       | Change the current user's password |

: All internal routes, under the `/private/` URL prefix.


| Method | Path                             | Description
|--------|----------------------------------|-----------|
| POST   | /login                           | Log in using credentials |
| POST   | /refresh                         | Refresh access token |
| POST   | /register                        | Register a new user account |

: A group of authentication related routes, under the `/v1/auth/` URL prefix.



| Method | Path                             | Description
|--------|----------------------------------|-----------|
| GET    | /                                | Get information about an individual user
| GET    | /followers                       | Get an individual user's list of followers
| GET    | /following                       | Get a list of users an individual user follows

: A group of routes relating to an individual user, under the `/v1/users/:user_id/` URL prefix.



| Method | Path    | Description
|--------|---------|-----------------------|
| GET    | /          | Get information about the current user |
| GET    | /profile   | Get the current user's profile _data_
| PATCH  | /profile   | Change the current user's profile _data_
| | | |
| | /follow/:target_user | **Subgroup** determining how the current user follows another
| GET    | /    | Check if following the target user
| PUT    | /    | Follow the target user
| DELETE | /    | Unfollow the target user

: A group of routes relating to the current user, under the `/v1/user/` URL prefix. This includes a `/follow/:target_user` **subgroup**.


| Method | Path                             | Description
|--------|----------------------------------|-----------|
| GET    | /                                | List resources |
| POST   | /                                | Create a new empty resource |
|        | /:user_id/:resource_id           | **Subgroup** relating to an individual user's resource |

: A group of resource related routes under the `/v1/resources/` URL prefix.

| Method | Path                             | Description
|--------|----------------------------------|-----------|
| GET    | /                                | Get resource information |
| PATCH   | /                                | Change resource metadata |
| DELETE       | /           | Delete the resource |
| | | |
| POST       | /transfer           | Transfer resource ownership to another |
| | | |
| PUT | /collaborators/:target_user | Add a collaborator |
| DELETE | /collaborators/:target_user | Delete a collaborator |
| | | |
| GET | /pkg | Get information about a package |
| POST | /pkg | Create an empty package or upload a package |
| | | |
|  | /pkg/:pkg_id | **Subsubgroup** relating to an individual resource's package |
| GET | / | Get package information |
| GET | /download | Download the package |
| PUT | /upload | Update the package |



: A group of routes relating to an individual user's resource, under the `/v1/resources/:user_id/:resource_id/` URL prefix.

\elandscape
