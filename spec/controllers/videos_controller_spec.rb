require 'spec_helper'

describe VideosController do 
  describe "GET show" do
    context "with authenticated users" do
      before do
        session[:user_id] = Fabricate(:user).id
      end
      it "sets @video" do
        video = Fabricate(:video)
        get :show, id: video.id
        expect(assigns(:video)).to eq(video)
      end

      it "sets @reviews for authenticated users" do
        session[:user_id] = Fabricate(:user).id
        video = Fabricate(:video)
        review1 = Fabricate(:review, video: video)
        review2 = Fabricate(:review, video: video)
        get :show, id: video.id
        expect(assigns(:reviews)).to match_array([review1, review2])
      end
      context "with unauthenticated users" do
        it "redirects the user to the sign in page" do
          video = Fabricate(:video)
          get :show, id: video.id
          response.should render_template root_path
        end
      end
    end
  end
end
