# Welcome to Wordly

Wordly is a blogging engine that aims to make the process of building, deploying and maintaining a blog easy, fun and flexible
without compromising on user-friendless.

You might say that Wordly tries to be both developer-friendly and user-friendly.

## The "Why?"

Does the world really need another blog engine? After all, we have Wordpress, perhaps the greatest blog engine ever created.
The short answer is "Yes" (you wouldn't be here otherwise, would you?)

Not all blogs were created equal. Indeed, a lot of blog owners are not programmers and care only about easily and quickly fitting
their blog with a ready-made theme, and hosting it on a Web host of their choice. This is where Wordpress really shines
and where Wordly doesn't try to outshine it.

However, many times, potential blog / site owners reach out to us, the developers, to build them a custom-made blog or personal
Website, with all kinds of far-fetched requirements like 3rd-party login, Facebook and Twitter support or semantic search (how dare they, right?).
This is where Wordpress falls short, and Wordly tries to stand out. By using industry-standard, community-supported technologies, Wordly
tries to make the process of modifying, customizing, extending and maintaining a blog fun and enjoyable, while helping you maintain healthy
blood pressure levels.

With all that said and done, let's get started

## Getting Started

To get started with Wordly, you need a basic knowledge of Ruby on Rails, the underlying framework on which Wordly is built. The
rest should be a pretty easy ride from there, as Wordly uses publicly available tools, like ActiveAdmin or Twitter Bootstrap to
magically drive your blog into fame and fortune.

To get started with Wordly you'll need to:

1. Clone the Wordly repository to your local machine
1. Make sure you have Ruby and Ruby gems installed (RVM is recommended for local development)
1. Make sure you have a running ActiveRecord-compliant database (MySQL, Postgresql, SQLite) installed and working
1. Run `bundle install` inside the clone repository
1. Run `rake db:migrate` to load the database scheme
1. Set up your blog information in `config/settings.yml`
1. Fire up your rails server with `rails s` and navigate to http://localhost:3000/admin
