require 'spec_helper'

describe Video do
  it "saves itself" do
    video = Video.new(title: "Video Title", description: "Some Description")
    video.save
    expect(Video.first.title).to eq("Video Title")
    expect(Video.first.description).to eq("Some Description")
  end
end
