require 'spec_helper'

describe Admin::UsersController do
  stub_current_user
  stub_rendering

  describe "GET edit" do
    it "assigns user to current_user" do
      get :edit
      expect(assigns[:user]).to eq current_user
    end
  end

  describe "PATCH update" do
    before do
      current_user.stub :update
    end

    it "assigns user to current_user" do
      patch :update, user: {some: 'attributes'}
      expect(assigns[:user]).to eq current_user
    end

    it "updates the user" do
      current_user.should_receive(:update).with('email' => 'new-email@example.org')
      patch :update, user: {email: 'new-email@example.org'}
    end

    it "responds with the user" do
      controller.should_receive(:respond_with).with(current_user, location: edit_admin_user_path)
      patch :update, user: {some: 'attributes'}
    end
  end
end
