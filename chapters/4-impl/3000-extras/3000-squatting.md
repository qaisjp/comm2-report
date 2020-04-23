
# Preventing resource squatting {#sec:squatting}

Resources in the existing system are scoped to a global level. This means that there is no way to upload a resource if there already exists a resource with the same name, making the site susceptible to "name-squatting".

Name-squatting, a form of _cybersquatting_, is the practice of registering - and not legitimately using - popular names in the hope to mislead others, or block others from using the name for a genuine purpose.

We checked to see if there are any user accounts that appear to "squat" on a large number of resource names. On the existing system's database, we first we ran the following query to get the list of users that own at least twenty resources.

```sql
with owners as (
    select owner_id, count(owner_id) as freq
    from resource_owners
    group by owner_id
    having count(owner_id) > 20
    order by freq desc
)
```

This allowed us to run a number of additional queries to find more detailed information.

**Usernames, IDs and frequency of uploaded resources**

```sql
select users.id, owners.freq
from owners, users
where users.id = owners.owner_id;
```

| id      | freq | description
| ------- | ---- | -----------
| 401291  | 131  | racing maps                          <!-- https://community.mtasa.com/index.php?p=profile&id=401291 -->
| 399788  | 82   | racing maps                          <!-- https://community.mtasa.com/index.php?p=profile&id=399788 -->
| 386833  | 82   | racing maps                          <!-- https://community.mtasa.com/index.php?p=profile&id=386833 -->
| 414347  | 80   | unique misc scripts (all Polish)     <!-- https://community.mtasa.com/index.php?p=profile&id=414347 -->
| 416671  | 61   | racing maps                          <!-- https://community.mtasa.com/index.php?p=profile&id=416671 -->
| 320386  | 53   | unique misc scripts, shaders         <!-- https://community.mtasa.com/index.php?p=profile&id=320386 -->
| 386795  | 49   | unique misc scripts (all Turkish)    <!-- https://community.mtasa.com/index.php?p=profile&id=386795 -->
| 356346  | 47   | racing maps                          <!-- https://community.mtasa.com/index.php?p=profile&id=356346 -->
| 347609  | 44   | unique misc scripts                  <!-- https://community.mtasa.com/index.php?p=profile&id=347609 -->
| 281213  | 43   | unique misc scripts (all Spanish)    <!-- https://community.mtasa.com/index.php?p=profile&id=281213 -->

: Top ten resource authors with a brief description of the kinds of resource that each user has uploaded.
Descriptions have been produced by human-interpreting resource descriptions, and not programmatically. {#tbl:bg-top10-authors}

From [@tbl:bg-top10-authors], we can deduce that the top authors are useful contributors to the platform.

When we look further into the leading user account (id 401291) we can see many similar uploads of a similar format, with resource names incrementing sequentially from `racemap1` to `racemap129`. This is considered by the community to be abusive behaviour.

**Summary**

The analysis above suggests that "resource squatting" is a problem that needs to be resolved. To solve this problem we will scope resources to individual user accounts. This also makes it easier for scripters to upload resources as they will not need to choose a globally unique resource name, and they can just use the resource name that they used during development.
