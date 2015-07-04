require 'spec_helper'

describe UsersController do
  describe "GET new" do 
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    context "valid input" do 
      before do
          post :create, user: {email: "dave@dave.com", full_name: "David carcar", password: "password"}
      end
      it "creates the user" do    
        expect(User.count).to eq(1)
      end
      it "redirects to signin path" do
        expect(response).to redirect_to home_path
      end
    end
    context "invalid input"  do
      before do
           post :create, user: { full_name: "David carcar", password: "password"}
      end
      it "does not create a user" do  
        expect(User.count).to eq(0)
      end
      it "renders the new template" do
        expect(response).to render_template :new
      end
      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end
end