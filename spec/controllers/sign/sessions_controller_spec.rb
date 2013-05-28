require 'spec_helper'

module Sign
  describe SessionsController do
    stub_rendering

    let(:login) { double :login }

    describe "GET new" do
      it "assigns new login" do
        Login.stub new: login
        get :new
        expect(assigns[:login]).to eq login
      end
    end

    describe "GET create" do
      before do
        Login.stub(:new).with('email' => 'some', 'password' => 'some').and_return login
        login.stub user_id: 1
      end

      it "sets session user id to the login id" do
        post :create, sign_login: {email: 'some', password: 'some'}
        expect(session[:user_id]).to eq 1
      end

      it "assigns the new login" do
        post :create, sign_login: {email: 'some', password: 'some'}
        expect(assigns[:login]).to eq login
      end

      it "responds with the new login" do
        controller.should_receive(:respond_with).with(login, location: admin_root_path)
        post :create, sign_login: {email: 'some', password: 'some'}
      end
    end

    describe "DELETE destroy" do
      it "removes user id from session" do
        session[:user_id] = 1
        delete :destroy
        expect(session[:user_id]).to be_nil
      end

      it "redirects to new session page" do
        delete :destroy
        expect(controller).to redirect_to sign_in_path
      end
    end
  end
end
