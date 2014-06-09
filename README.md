# IT Tour

The site used for conferences part of the "[IT Tour](http://it-tour.bg)".

Conferences:

* [VarnaConf](http://varnaconf.com)
* [PlovdivConf](http://plovdivconf.com)
* [BurgasConf](http://burgasconf.com)
* [TarnovoConf](http://tarnovoconf.com/)
* [BlagoevgradConf.com](http://blagoevgradconf.com/)

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
