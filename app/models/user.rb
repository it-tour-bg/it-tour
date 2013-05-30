class User < ActiveRecord::Base
  has_secure_password

  validates :password_confirmation, presence: {if: 'password.present?'}

  validates :email, uniqueness: true, email: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end
