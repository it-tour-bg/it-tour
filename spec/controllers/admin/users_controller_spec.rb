require 'spec_helper'

describe Admin::UsersController do
  stub_current_user

  describe "GET edit" do
    it "assigns user to current_user" do
      get :edit
      expect(assigns[:user]).to eq current_user
    end
  end

  describe "PATCH update" do
    before do
      allow(current_user).to receive(:update)
    end

    it "assigns user to current_user" do
      patch :update, user: {some: 'attributes'}
      expect(assigns[:user]).to eq current_user
    end

    it "updates the user" do
      patch :update, user: {email: 'new-email@example.org'}

      expect(current_user).to have_received(:update).with('email' => 'new-email@example.org')
    end

    it "responds with the user" do
      patch :update, user: {some: 'attributes'}

      expect(controller).to respond_with(current_user, location: edit_admin_user_path)
    end
  end
end
