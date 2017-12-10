require 'spec_helper'

describe Category do

  it {should have_many :videos}

  describe "#recent_videos" do
    before(:each) do
      @category1 = Category.create(name: "Drama")
      @category2 = Category.create(name: "Comedy")
      @video1 = Video.create(title: "Family Guy", description: "A family man", created_at: 7.days.ago)
      @video2 = Video.create(title: "Futurama", description: "To the moon", created_at: 6.days.ago)
      @video3 = Video.create(title: "South Park", description: "It's in Colorado", created_at: 5.days.ago)
      @video4 = Video.create(title: "Family Guy 2", description: "A family man 2", created_at: 4.days.ago)
      @video5 = Video.create(title: "Futurama 2", description: "To the moon 2", created_at: 3.days.ago)
      @video6 = Video.create(title: "South Park 2", description: "It's in Colorado 2", created_at: 2.days.ago)
      @video7 = Video.create(title: "Never See ME", description: "I don't exist")
    end

    it "should return an empty array if no videos in the category" do
      result = @category1.recent_videos
      expect(result.size).to eq(0)
      result = @category2.recent_videos
      expect(result.size).to eq(0)
    end
    it "should return an array of maximum size 6 for a category" do
      @category1.videos << @video1 << @video2 << @video3 << @video4 << @video5 << @video6 << @video7
      result = @category1.recent_videos
      expect(result.size).to eq (6)
      result = @category2.recent_videos
      expect(result.size).to eq (0)
      @category2.videos << @video1 << @video4 << @video7
      result = @category2.recent_videos
      expect(result.size).to eq(3)
    end
    it "should return an array with entries in newest->oldest order" do
      @category1.videos << @video1 << @video2 << @video3 << @video4 << @video5 << @video6 << @video7
      result = @category1.recent_videos
      expect(result[0]).to eq(@video7)
      expect(result[1]).to eq(@video6)
      expect(result.last).to eq(@video2)
    end

  end

end
