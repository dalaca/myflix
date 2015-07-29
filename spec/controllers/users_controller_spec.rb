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
        expect(User.last).to be
      end
      it "redirects to signin path" do
        expect(response).to redirect_to home_path
      end
    end

    context "sending email" do
      after {ActionMailer::Base.deliveries.clear}

      it "sends an email" do      
      post :create, user: {email: "dave@dave.com", full_name: "David carcar", password: "password"}
      expect(ActionMailer::Base.deliveries.last.to).to eq(["dave@dave.com"])
    end
      it "send correct user name for user email" do
        post :create, user: {email: "dave@dave.com", full_name: "David carcar", password: "password"}
      expect(ActionMailer::Base.deliveries.last.body).to include("David carcar")
      end
    it "does not send an email with invalid inputs" do
       post :create, user: { full_name: "David carcar"}
      expect(ActionMailer::Base.deliveries).to be_empty 
    end
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

    describe "GET show" do
      it_behaves_like "requires sign in" do
        let(:action) {get :show, id: 3}
      end
      it "sets @user" do
        alice = Fabricate(:user)
        set_current_user(alice)
        
        get :show, id: alice.id
        expect(assigns(:user)).to eq(alice)
      end
    end
  end