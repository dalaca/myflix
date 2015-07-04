require 'spec_helper'

  describe Category do
    

    it { should have_many(:videos)}
    it { should validate_presence_of(:name)}

    describe "#recent_videos" do
      it "returns the most recent videos in descending order by created at" do
        comedies = Category.create(name: "comedies")
        south_path = Video.create(title: "South Park", description: "funny hahah", category: comedies, created_at: 1.day.ago)
        futurama = Video.create(title: "Futurama", description: "cartoon", category: comedies)
        expect(comedies.recent_videos).to eq([futurama, south_path])
      end
      it "return all the videos of if less than 6 videos" do
        comedies = Category.create(name: "comedies")
        south_path = Video.create(title: "South Park", description: "funny hahah", category: comedies, created_at: 1.day.ago)
        futurama = Video.create(title: "Futurama", description: "cartoon", category: comedies)
        expect(comedies.recent_videos.count).to eq(2)
      end
      it "returns a maximum of 6 videos for the specfied category" do
        comedies = Category.create(name: "comedies")
        7.times {Video.create(title: "yolo", description: "funny times", category: comedies)}
        expect(comedies.recent_videos.count).to eq(6)
      end
      it "returns the most recent 6 videos" do
        comedies = Category.create(name: "comedies")
        6.times {Video.create(title: "yolo", description: "funny times", category: comedies)}
        tonight_show = Video.create(title: "Jay Leno", description: "talk show host", category: comedies, created_at: 1.day.ago)
        expect(comedies.recent_videos).not_to include(tonight_show)

      end
      it "returns an empty array if no videos in category" do
        comedies = Category.create(name: "comedies")
        expect(comedies.recent_videos).to eq([])
      end
    end
  end