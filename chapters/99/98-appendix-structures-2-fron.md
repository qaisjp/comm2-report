# Frontend

## `LoginResponse`

```ts
// auth.service.ts
interface LoginResponse {
  token: string;
  expire: string;
}
```

: LoginResponse {#lst:typf-LoginResponse}

## `User`

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

: l {#lst:typf-User}

## `AuthenticatedUser`

```ts
export interface AuthenticatedUser extends User {
  readonly updated_at: string;
}
```

: l {#lst:typf-AuthenticatedUser}

## `UserProfile`, `UserProfileData`

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

: l {#lst:typf-UserProfile}


## `Resource`

```ts
// resource.service.ts
export interface Resource {
  readonly id: number;
  readonly created_at: string;
  readonly updated_at: string;
  author_id: number;
  name: string;
  title: string;
  description: string;
  short_description: string;
  visibility: ResourceVisibility;
  archived: boolean;
  authors: User[];
  readonly can_manage: boolean;
  download_count: number;
}
```

: Resource {#lst:typf-Resource}

## `ResourceVisibility`

```ts
export enum ResourceVisibility {
  PUBLIC = 'public',
  PRIVATE = 'private',
}
```

: ResourceVisibility {#lst:typf-ResourceVisibility}

## `ResourcePackage`

```ts
export interface ResourcePackage {
  readonly id: number;
  readonly created_at: string;
  readonly updated_at: string;
  published_at?: string;
  uploaded_at?: string;

  readonly resource_id: number;
  readonly author_id: number;
  version: string;
  description: string;
  file_uploaded: boolean;
}
```

: ResourcePackage {#lst:typf-ResourcePackage}

## Derived resource types

```ts
export type ResourceCreateResponse = Readonly<Pick<Resource, 'id'>>;
export type ResourcePatchRequest = Partial<
	Pick<Resource,
		'name' | 'title' | 'description' | 'visibility' | 'archived'
	>>;

// ResourceID can either be the name of the resource, or its numeric ID
export type ResourceID = Resource['id'] | Resource['name'];
```

: Derived {#lst:typf-ResDerived}
