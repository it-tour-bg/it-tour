task :create_user => :environment do
  first_name = ENV['first_name'].dup
  last_name  = ENV['last_name'].dup
  email      = ENV['email'].dup
  password   = ENV['password'].dup

  User.create! first_name: first_name, last_name: last_name, email: email, password: password, password_confirmation: password
end
