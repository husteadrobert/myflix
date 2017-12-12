require 'spec_helper'

describe Video do

  it {should belong_to :category}

  it {should validate_presence_of :title }

  it {should validate_presence_of :description }

  it {should have_many(:reviews).order("created_at DESC") }

  describe 'Video.search_by_title' do
    before(:each) do
      @video1 = Video.create(title: "Family Guy", description: "A family man", created_at: 5.days.ago)
      @video2 = Video.create(title: "Futurama", description: "To the moon", created_at: 3.days.ago)
      @video3 = Video.create(title: "South Park", description: "It's in Colorado")
    end

    it "should return an empty array if no hits" do
      result = Video.search_by_title("blehhhh")
      expect(result).to eq([])
    end
    it "should return an array of values if has hits" do
      result = Video.search_by_title('F')
      expect(result.size).to be > 0
    end
    it "should return a video without full title" do
      result = Video.search_by_title("Park")
      expect(result[0].title).to eq("South Park")
    end
    it "should return correct videos" do
      result = Video.search_by_title("South Park")
      expect(result[0].title).to eq("South Park")
    end
    it "should return videos in newest->oldest" do
      result = Video.search_by_title ("a")
      # expect(result[0].title).to eq("South Park")
      # expect(result[1].title).to eq("Futurama")
      # expect(result[2].title).to eq("Family Guy")
      expect(result[0].created_at).to be > result[1].created_at
    end
    it "returns an empty array if search terms are empty" do
      result = Video.search_by_title("")
      expect(result).to eq([])
    end

    it "is case insensitive" do
      result = Video.search_by_title("f")
      expect(result.size).to be > 1
      result = Video.search_by_title("F")
      expect(result.size).to be > 1
    end
  end

  describe '#average_rating' do
    it "should calculate the average rating" do
      video = Fabricate(:video)
      review1 = Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)
      review3 = Fabricate(:review, video: video)
      expect(video.average_rating).to eq(3)
      video2 = Fabricate(:video)
      review1 = Fabricate(:review, video: video2, rating: 5)
      review2 = Fabricate(:review, video: video2, rating: 2)
      review3 = Fabricate(:review, video: video2, rating: 3)
      average = ((5 + 2 + 3) / 3.0).round(1)
      expect(video2.average_rating).to eq(average)
      video3 = Fabricate(:video)
      review1 = Fabricate(:review, video: video3, rating: 5)
      expect(video3.average_rating).to eq(5)
    end
    it "should return 0.0 if no ratings" do
      video = Fabricate(:video)
      expect(video.average_rating).to eq(0.0)
    end
  end
end
