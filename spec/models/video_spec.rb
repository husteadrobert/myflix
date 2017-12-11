require 'spec_helper'

describe Video do

  it {should belong_to :category}

  it {should validate_presence_of :title }

  it {should validate_presence_of :description }

  describe 'Video.search_by_title' do
    before(:each) do
      @video1 = Video.create(title: "Family Guy", description: "A family man")
      @video2 = Video.create(title: "Futurama", description: "To the moon")
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
      expect(result[2].title).to eq("South Park")
      expect(result[1].title).to eq("Futurama")
      expect(result[0].title).to eq("Family Guy")
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
    it "should calculate the average rating"
    it "should return 0 if no ratings"
  end
end
