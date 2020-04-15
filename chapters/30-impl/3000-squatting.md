
# Preventing resource squatting {#sec:squatting}

Resources in the existing system are scoped to a global level. This means that there is no way to upload a resource if there already exists a resource with the same name.

We think this makes the site susceptible to "name-squatting". Name-squatting, a form of _cybersquatting_, is the practice of registering - and not legitimately using - popular names in the hope to mislead others, or block others from using the name for a genuine purpose.

We checked to see if there are any user accounts that appear to "squat" a large number of resource names. On the existing system's database, we first we ran the following query to get the list of users that own at least twenty resources.

```sql
with owners as (
    select owner_id, count(owner_id) as freq
    from resource_owners
    group by owner_id
    having count(owner_id) > 20
    order by freq desc
)
```

This allowed us to run a number of additional queries to find more detailed information. The information below is public, and therefore _not_ anonymised.

**Usernames, IDs and frequency of uploaded resources**

```sql
select users.id, users.username, owners.freq
from owners, users
where users.id = owners.owner_id;
```

| id     | username           | freq | description
| -------| ------------------ | ---- | -----------
| 401291 | _Lorimaxxx_        | 131  | racing maps                          <!-- https://community.mtasa.com/index.php?p=profile&id=401291 -->
| 399788 | _4VCI.SincaN.Pro._ | 82   | racing maps                          <!-- https://community.mtasa.com/index.php?p=profile&id=399788 -->
| 386833 | _Mapper.Creed_     | 82   | racing maps                          <!-- https://community.mtasa.com/index.php?p=profile&id=386833 -->
| 414347 | _MartinPanZycia_   | 80   | unique misc scripts (all Polish)     <!-- https://community.mtasa.com/index.php?p=profile&id=414347 -->
| 416671 | _Reiko:_           | 61   | racing maps                          <!-- https://community.mtasa.com/index.php?p=profile&id=416671 -->
| 320386 | _Ren712_           | 53   | unique misc scripts, shaders         <!-- https://community.mtasa.com/index.php?p=profile&id=320386 -->
| 386795 | _[k.r.a.l.]baris_  | 49   | unique misc scripts (all Turkish)    <!-- https://community.mtasa.com/index.php?p=profile&id=386795 -->
| 356346 | _ByCasinoTR_       | 47   | racing maps                          <!-- https://community.mtasa.com/index.php?p=profile&id=356346 -->
| 347609 | _Dutchman101_      | 44   | unique misc scripts                  <!-- https://community.mtasa.com/index.php?p=profile&id=347609 -->
| 281213 | _ATODOHACK_        | 43   | unique misc scripts (all Spanish)    <!-- https://community.mtasa.com/index.php?p=profile&id=281213 -->

: Top ten resource authors with a brief description of the kinds of resource that each user has uploaded.
Descriptions have been produced by glancing at resource descriptions, and not programmatically. {#tbl:bg-top10-authors}

From [@tbl:bg-top10-authors], we can deduce that the top authors are useful contributors to the platform.

When we look further into the leading user account (id 401291) we can see many similar uploads of a similar format, but containing unique content.
Most resource names follow a scheme, incrementing sequentially from `racemap1` to `racemap129`, which is considered to be abusive behaviour.

**Summary**

The analysis above suggests that "resource squatting" is a problem that needs to be resolved. To solve this problem we will scope resources to individual user accounts. This also makes it easier for scripters to upload resources as they will not need to choose a globally unique resource name, and they can just use the resource name that they used during development.
