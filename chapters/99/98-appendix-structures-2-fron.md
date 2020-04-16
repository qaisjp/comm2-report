# Frontend

: `LoginResponse` {#lst:typf-LoginResponse}
```ts
// auth.service.ts
interface LoginResponse {
  token: string;
  expire: string;
}
```

: `User` {#lst:typf-User}
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

: `AuthenticatedUser` {#lst:typf-AuthenticatedUser}
```ts
export interface AuthenticatedUser extends User {
  readonly updated_at: string;
}
```

: `UserProfile` and `UserProfileData` {#lst:typf-UserProfile}
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

: `Resource` {#lst:typf-Resource}
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

: `ResourceVisibility` {#lst:typf-ResourceVisibility}
```ts
export enum ResourceVisibility {
  PUBLIC = 'public',
  PRIVATE = 'private',
}
```

: `ResourcePackage` {#lst:typf-ResourcePackage}
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

: Derived resource types {#lst:typf-ResDerived}
```ts
export type ResourceCreateResponse = Readonly<Pick<Resource, 'id'>>;
export type ResourcePatchRequest = Partial<
	Pick<Resource,
		'name' | 'title' | 'description' | 'visibility' | 'archived'
	>>;

// ResourceID can either be the name of the resource, or its numeric ID
export type ResourceID = Resource['id'] | Resource['name'];
```
