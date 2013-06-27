# IT Tour

The site used for conferences part of the "IT Tour".

Conferences:

* [VarnConf](http://varnaconf.com)
* [PlovdivConf](http://plovdivconf.com)

## Installation

```
gem install bundler
bundle install
rake db:create
rake db:schema:load
rake create_user first_name="Your" last_name="Name" email="mail@example.com" password="12345"
rails server
```

From there just visit: [localhost:3000/admin/](http://localhost:3000/admin/)


## Description

The site can handle multiple ```Conference```s. Each conference is planed to live on a separate domain.
One conference can have multiple events.

There is a share list of speakers and subscribers to all conferneces.
