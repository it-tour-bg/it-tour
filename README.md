# IT Tour

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
