# README

This application is a really simple service status dashboard I decided to build because I do not like the available options...

The simple options that did exactly what I wanted are now part of a full and complex option that I do not need, or the available options simple do not do what I want...

What I need is simple, just show me what services are online or offline and let me know through email or other notification that they failed or recovered (for now just email, I'll add more notifications later)

This is stupdly simple right now, it doesn't even have an administration dashboard, but it is doing what I need right now.

I'll improve the system later.

It was built using: 

* Ruby 2.5.0
* Rails 5.1.6
* Sidekiq 5.1.1

And since it uses Sidekiq it requires redis to run

This is the very first version I've built in my machine, and is not in production yet

I know it has no tests, I know it is ugly, I'll fix it, sorry for that
