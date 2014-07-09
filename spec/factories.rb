FactoryGirl.define do
  sequence(:session_start_at) { |n| "#{'%02d' % (23 - n/60).abs}:#{'%02d' % (n%60)}"  }
  sequence(:email) { |n| "user-#{n}@example.org" }
  sequence(:domain) { |n| "example-#{n}.org" }

  factory :conference do
    name 'Conference name'
    contact_name 'Contact person'
    contact_email 'contact@example.org'
    domain { generate :domain }
  end

  factory :event do
    conference
    name 'year name'
    date Date.new(2013, 6, 20)
    publicly_announced true
    current false

    factory :future_event do
      publicly_announced false
    end

    factory :current_event do
      current true
    end

    factory :finished_event do
      date { 1.year.ago }
    end
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

  factory :speaker do
    name 'John Doe'
  end

  factory :subscriber do
    email { generate :email }
  end

  factory :feedback do
    event
    comment "I liked the event"
  end

  factory :photo do
    event
    asset { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/photo_asset.jpg').to_s) }
  end

  factory :session_speaker do
    session { build :session }
    speaker { build :speaker }
  end
end
