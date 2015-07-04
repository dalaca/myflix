require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "renders the new template for authenticated users" do 
      get :new 
      expect(response).to render_template :new
    end
      it "redirects to the the home page for unauthenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe "POST create" do
    context "with valid credentials" do
      it "puts the signed in user in the session" do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password, full_name: alice.full_name
        expect(session[:user_id]).to eq(alice.id)
      end
      it "redirects to the home page" do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password, full_name: alice.full_name
        expect(response).to redirect_to home_path
      end
      it "sets the notice" do
         alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password, full_name: alice.full_name
        expect(flash[:notice]).not_to be_blank
      end
    end
    context "with  invalid credentials" do
      it "does not put the signed in user into the session" do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password + "assds", full_name: alice.full_name
        expect(session[:user_id]).to be_nil
      end
      it "redirects to sign in page"
      it "shows an error message"

    end
  end
end
