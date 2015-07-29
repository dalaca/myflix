require 'spec_helper'

feature 'User following' do
  scenario "user follows and unfollows someone" do
    alice = Fabricate(:user)
    category = Fabricate(:category)
    video = Fabricate(:video, category: category)
    Fabricate(:review, user: alice, video: video)

    sign_in
    
    find("a[href='/videos/#{video.id}']").click

    click_link alice.full_name
    click_link "Follow"
    expect(page).to have_content(alice.full_name)

    unfollowed(alice)
    expect(page).not_to have_content(alice.full_name)
  end

  def unfollowed(user)
    find("a[data-method='delete']").click
  end
end


  

