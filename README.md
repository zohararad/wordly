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

## Diving in deeper

Head over to the [Wordly Wiki](https://github.com/zohararad/wordly/wiki) where you can find information about themes, SEO and other general goodness

## Legal

### The License (yup, its MIT)

Copyright (c) 2012 Zohar Arad <zohar@zohararad.com>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

### The Pledge

By using Wordly, you would also agree to:

1. Frown upon Wordpress developers at every opportunity
1. Spread the word of Wordly to your loved ones, colleagues and the endangered arctic pinguins to the best of your ability
1. Buy the Wordly project owner a pint of high-quality beer if you should ever meet him
1. Cause no harm to cute, furry arctic animals

## Contributing

Please feel free to either open issues on the project's issue tracker here on Github, or alternatively, fork the code, fix and send me a pull request.

Any internationalization efforts (to ActiveAdmin in particular) will be greatly appreciated and happily received.
