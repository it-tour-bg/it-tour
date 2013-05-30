require 'spec_helper'

describe EmailValidator do
  EmailValidatorTestCase = Class.new do
    include ActiveModel::Validations

    attr_reader :email

    validates :email, email: true

    def initialize(email)
      @email = email
    end
  end

  def new_model(email)
    EmailValidatorTestCase.new(email)
  end

  it "returns true if mails is valid" do
    expect(new_model('valid-email@example.com')).to be_valid
  end

  it "returns false if mails is valid" do
    expect(new_model('this is no an email')).to_not be_valid
  end
end
