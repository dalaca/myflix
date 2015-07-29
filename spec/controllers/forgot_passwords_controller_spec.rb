require 'spec_helper'

describe ForgotPasswordsController do 
  describe "POST create" do 
    context "With blank input" do
      it "redirects to the forgot password" do
        post :create, email: ('') 
        expect(response).to redirect_to forgot_password_path
      end
      it "shows an errors page" do 
        post :create, email: ('') 
        expect(flash[:error]).to be_truthy
      end
    end
    context "with existing email" do
      it "redirect_to to the forgot password confirmation page" do
        Fabricate(:user, email: "a@a.com")
        post :create , email: ("a@a.com")
        expect(response).to redirect_to forgot_password_confirmation_path
      end
      it "sends out an email to the email address" do
        Fabricate(:user, email: "a@a.com")
        post :create , email: ("a@a.com")
        expect(ActionMailer::Base.deliveries.last.to).to eq(["a@a.com"])        
      end
    end
    context "with non-existing email" do
      it 'redirect_to the forgot_password page' do
        post :create, email: 'foo@foo.com'
        expect(response).to redirect_to forgot_password_path
      end
      it 'shows and error message' do
        post :create, email: 'foo@foo.com'
        expect(flash[:error]).to eq("There is no user with this email")
      end
    end
  end
end