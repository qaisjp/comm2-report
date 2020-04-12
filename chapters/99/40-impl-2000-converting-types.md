
# Converting Go types

We use the `encoding/json` package in the Go standard library to convert Go types to and from JSON. This process is called marshalling and unmarshalling:

> "Marshal returns the JSON encoding of v."
> ```go
> func Marshal(v interface{}) ([]byte, error)
> ```
>
> "Unmarshal parses the JSON-encoded data and stores the result in the value pointed to by v."
> ```go
> func Unmarshal(data []byte, v interface{}) error
> ```
> [@JsonGoProgramming]

Go supports tagging structs with plaintext strings. These strings have a well-established convention for standard introspection during runtime their Go's reflection library.

Where the `json` tag is provided (see `AuthenticatedUser.Level` in [@lst:typa-AuthenticatedUser]), the value corresponds to the field inside the JSON dictionary. Nested fields are not supported.

As shown in `UserProfile.UserID` ([@lst:typa-UserProfile]), a value of `"-"` means that this field should be ignored during marshalling or unmarshalling[^note-marshalling]. Providing an additional value `omitempty` (see `PublicUserInfo.FollowsYou` in [@lst:typa-PublicUserInfo]) means that a zero value will result in that field being omitted during JSON marshalling.

Our SQL package, `github.com/jmoiron/sqlx`, internally uses the `database/sql` package from the standard library, allowing us to use take advantage of the pre-existing tagging functionality available.

Where the `db` tag is provided (see `User.ID` in [@lst:typa-User]), the value corresponds to the column name in the database (in `User.ID` the column is `id`).
