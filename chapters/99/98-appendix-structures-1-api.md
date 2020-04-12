# API

## `User`

```go
// User represents a user account
type User struct {
	ID        uint64    `db:"id"`
	CreatedAt time.Time `db:"created_at"`
	UpdatedAt time.Time `db:"updated_at"`

	Username string `db:"username"`
	Password string `db:"password"`
	Email    string `db:"email"`
	Level     int  `db:"level"`
	Activated bool `db:"is_activated"`
	Banned    bool `db:"is_banned"`
}
```

: User {#lst:typa-User}

## `UserProfile`

```go
// UserProfile represents a user's public profile information
type UserProfile struct {
	UserID       uint64 `db:"user_id" json:"-"`
	Location     string `db:"location" json:"location"`
	Organisation string `db:"organisation" json:"organisation"`
	Website      string `db:"website" json:"website"`
	Bio          string `db:"bio" json:"bio"`
}
```

: UserProfile represents a user's public profile information {#lst:typa-UserProfile}

## `PublicUserInfo`

```go
// PublicUserInfo represents the public fields of a user object
type PublicUserInfo struct {
	ID        uint64    `json:"id"`
	CreatedAt time.Time `json:"created_at"`
	UpdatedAt time.Time `json:"updated_at"`

	Username string `json:"username"`
	Gravatar string `json:"gravatar"`

	FollowsYou *bool `json:"follows_you,omitempty"`
}
```

: PublicUserInfo represents the public fields of a user object {#lst:typa-PublicUserInfo}

## `AuthenticatedUser`

```go
// AuthenticatedUser represents the fields available to an authenticated user
type AuthenticatedUser struct {
	PublicUserInfo
	Level int `json:"level"`
}
```

: AuthenticatedUser represents the fields available to an authenticated user {#lst:typa-AuthenticatedUser}


## `Resource`

```go
type Resource struct {
	ID        uint64    `db:"id" json:"id"`
	CreatedAt time.Time `db:"created_at" json:"created_at"`
	UpdatedAt time.Time `db:"updated_at" json:"updated_at"`
	AuthorID  uint64    `db:"author_id" json:"author_id"`

	Name        string `db:"name" json:"name"`
	Title       string `db:"title" json:"title"`
	Description string `db:"description" json:"description"`
    ShortDescription string `db:"-" json:"short_description"`

	Visibility string `db:"visibility" json:"visibility"`
	Archived   bool   `db:"archived" json:"archived"`
	DownloadCount int `db:"download_count" json:"download_count"`

	CanManage bool `db:"-" json:"can_manage"`
}
```

: Structure for resources {#lst:typa-Resource}

## `ResourceVisibility`

```go
const (
	ResourceVisibilityPublic  string = "public"
	ResourceVisibilityPrivate string = "private"
)
```

: Constants that represent the possible resource visibilities (Go does not support enums) {#lst:typa-ResourceVisibility}

## `ResourcePackage`

```go
type ResourcePackage struct {
	ID        uint64    `db:"id" json:"id"`
	CreatedAt time.Time `db:"created_at" json:"created_at"`
	UpdatedAt time.Time `db:"updated_at" json:"updated_at"`

	ResourceID  uint64 `db:"resource_id" json:"resource_id"` // relation
	AuthorID    uint64 `db:"author_id" json:"author_id"`     // relation
	Version     string `db:"version" json:"version"`
	Description string `db:"description" json:"description"`

	PublishedAt  *time.Time `db:"published_at" json:"published_at"`
	FileUploaded bool       `db:"-" json:"file_uploaded"`
	UploadedAt   *time.Time `db:"uploaded_at" json:"uploaded_at"`
}
```

: Structure for resource packages {#lst:typa-ResourcePackage}
