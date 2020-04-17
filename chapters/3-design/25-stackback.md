## Backend

We had three main reasons for choosing to build our API in Go:

1. Go compiles down to a single statically linked binary, making it easy to deploy.
2. Go is highly performant compared to the other languages we considered, while also being memory safe, type safe and mostly free of undefined behaviour.
3. Go does not slow the developer down: we can write code quickly, that code builds fast, and its runtime behaviour is predictable.

Go's webserver is multithreaded by default which improves its performance, but also makes it susceptible to Go's only undefined behaviour: _race conditions_. We can make use of Go's inbuilt concurrency primitives - _channels_ - to alleviate this problem^[More information on Go's concurrency features can be found at: https://github.com/golang/go/wiki/LearnConcurrency].

We also had the most prior experience writing software in Go, making the language an obvious choice.

Other languages we considered were:

- Python, which lacks many of the above properties. It is interpreted and weakly typed, resulting in a lot of runtime overhead, and therefore poor performance. While it is the fastest to write and does not need compiling, the lack of static typing makes it susceptible to runtime errors which could easily be resolved at compile time.
- Rust can be statically linked and has better performance than Go, but it is slow to write and compile, making it difficult to build and experiment with.
- C++ has the best performance but is not memory safe or free of undefined behaviour. These two properties would make the backend at risk of being vulnerable through memory exploits. A lot of developer time would be spent being extra careful to prevent the introduction of security vulnerabilities. Compile time is also an issue — "Go is significantly faster to compile over C++" [@GoVsComparison].

### Database

Storing information in a database allows us to persist data across multiple independent requests. We chose to store our data in a PostgreSQL database as

- Our data is relational, making SQL the better choice over NoSQL. [@SQLVsNoSQL]
- Compared to MySQL, PostgreSQL provides additional types (such as enumerations), case insensitive pattern matching (the `ilike` operator), and other extra features. [@MySQLVsPostgreSQL]
- The existing system already uses PostgreSQL so it will be easier to migrate to a new database schema than a completely different type of database.
