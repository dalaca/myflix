require 'spec_helper'

describe PasswordResetsController do
  describe "GET show" do
    it "renders the show template if the token is valid" do
      alice = Fabricate(:user, token:"12345")
      alice.update_column(:token, '12345')
      get :show, id: '12345'
      expect(response).to render_template :show
    end

    it 'sets @token' do
      alice = Fabricate(:user)
      alice.update_column(:token, '12345')
      get :show, id: '12345'
      expect(assigns(:token)).to eq('12345')
    end

    it 'redirects to the expired token page if the token is invalid' do
      get :show, id: '12345'
      expect(response).to redirect_to expired_token_path
    end
  end  
  
  describe "POST create" do
    context "with valid token" do
      it "Should redirect to sign in page" do
        alice = Fabricate(:user, password: 'old_password')
        alice.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'
        expect(response).to redirect_to root_path
      end
      it "update users password" do
        alice = Fabricate(:user, password: 'old_password')
        alice.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'
        expect(alice.reload.authenticate('new_password')).to be_truthy
      end
      it "flash success msg" do
        alice = Fabricate(:user, password: 'old_password')
        alice.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'
        expect(flash[:success]).to be_present
      end
      it "regenerate the user token" do
         alice = Fabricate(:user, password: 'old_password')
        alice.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'
        expect(alice.reload.token).not_to eq('12345')
      end
    end
    context 'with invalid token'do
    it 'redirects to the expired_token_path' do
      post :create, token: '12345', password: 'some_password'
      expect(response).to redirect_to expired_token_path
    end
  end
  end  
end