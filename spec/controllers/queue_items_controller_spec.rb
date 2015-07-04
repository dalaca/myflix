require 'spec_helper'

describe QueueItemsController  do
  describe "GET index" do
    it "sets @queue_items to the queue items of the logged in user" do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      queue1 = Fabricate(:queue_item, user: alice)
      queue2 = Fabricate(:queue_item, user: alice)
      get :index
      expect(assigns(:queue_items)).to match_array([queue1, queue2])
    end
    it "redirects to the sign in page for unauthenticated users" do
      get :index
      expect(response).to redirect_to root_path
    end
  end

  describe "POST create" do
    it "redirects to the my queue page" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path    
    end
    it "creates a queue item" do
      bruce = Fabricate(:user)
      session[:user_id] = bruce.id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end
    it "creates the queue item that is associated with the video"
    it "create the queue item that is associated to the signed in user"
    it "puts the video as the last one in the queue"
    it "does not add the video that is already in the queue"
    it "redirects to the sign in page for unauthenticated users"
  end
end