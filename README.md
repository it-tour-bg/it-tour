[![Code Climate](https://codeclimate.com/github/RStankov/it-tour.png)](https://codeclimate.com/github/RStankov/it-tour)
[![Build Status](https://travis-ci.org/RStankov/it-tour.png?branch=master)](https://travis-ci.org/RStankov/it-tour)

# IT Tour

The site used for conferences part of the "[IT Tour](http://it-tour.bg)".

Conferences:

* [VarnaConf](http://varnaconf.com)
* [PlovdivConf](http://plovdivconf.com)
* [BurgasConf](http://burgasconf.com)
* [TarnovoConf](http://tarnovoconf.com/)
* [RuseConf](http://ruseconf.com/)
* [BlagoevgradConf](http://blagoevgradconf.com/)
* [RuseConf](http://http://ruseconf.com/)

## Installation

Copy `config/database.yml.example` to `config/database.yml` and edit it to match your local configuration.

```
gem install bundler
bundle install
rake db:create
rake db:schema:load
rake create_user first_name="Your" last_name="Name" email="mail@example.com" password="12345"
rails server
```

From there just visit: [localhost:3000/admin/](http://localhost:3000/admin/) and create a new conference with the "example.com" domain. Afterwards, you should be able to visit the public site, ie. [localhost:3000](http://localhost:3000/).

## Description

The site can handle multiple ```Conference```s. Each conference is planed to live on a separate domain.
One conference can have multiple events.

There is a share list of speakers and subscribers to all conferneces.

## Local dev with Docker

- Prerequisites
In order to run the projects locally you need to:
  - Import a database dump from production, mainly confereces and events table. (full restore from a sql file is best option)
  - Change table `public.confereces` to match local setup, `domain`
  column holds what address responds to which conference

- Dev Note
  `db:migrate` should ran after a succesfull build, but it would
  generate an emtpy database, creating a user with rake task `users`
  should result in an admin user, and viting `/admin` will allow
  a conference and then event creation.

Start/stop
`docker-compose up --build --remove-orphans app db pgadmin`
`docker-compose down app db pgadmin`
