FactoryGirl.define do
  sequence(:session_start_at) { |n| "#{'%02d' % (23 - n/60).abs}:#{'%02d' % (n%60)}"  }
  sequence(:email) { |n| "user-#{n}@example.org" }

  factory :conference do
    name 'Conference name'
    contact_name 'Contact person'
    contact_email 'contact@example.org'
  end

  factory :event do
    conference
    name 'year name'
    date Date.new(2013, 6, 20)
  end

  factory :session do
    event
    title 'Session name'
    start_at { generate :session_start_at }
  end

  factory :user do
    first_name             'Joe'
    last_name              'Doe'
    email                  { generate :email }
    password               '123456'
    password_confirmation  '123456'
  end

  factory :email do
    email { generate :email }
  end
end
