class BackdoorController < ApplicationController
  before_action :restrict_access unless Rails.env.test?

  def login
    session[:user_id] = User.find_by_email!(params[:email])
    render nothing: true
  end

  def logout
    reset_session
    render nothing: true
  end

  private

  def prevent_from_execution_outside_test_environment
    raise "How can this happened?!"
  end
end
