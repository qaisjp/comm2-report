## Modules {#sec:modules}

Every module imports the `CommonModule` module from the Angular standard library.

The modules that we created are:

- AppModule - handles the entire application
    - AppRoutingModule - handles routing for the entire application
    - UserModule - provides a service to interact with all user _information_
    - ProfileModule - provides components to interact with all user _profile pages_
        - ProfileRoutingModule - handles routes relating to a user's profile
    - ResourceModule - provides services and components that interact with all resources
        - ResourceRoutingModule - handles routes relating to an individual resource
    - AuthModule - provides services and components relating to user _authentication_
    - OcticonModule - provides a directive to insert Primer's icons (known as "octicons")

Routing is discussed in more detail in [@sec:routing].
