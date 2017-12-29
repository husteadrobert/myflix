require 'spec_helper'

describe User do
  it { should validate_presence_of(:email_address) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:email_address) }
  it { should have_many(:queue_items).order("position") }
  it { should have_many(:reviews).order("created_at DESC") }

  it "generates a random token when the user is created" do
    alice = Fabricate(:user)
    expect(alice.token).to be_present
  end

  describe "#queued_video?" do
    it "returns true when the user queued the video" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      Fabricate(:queue_item, user: user, video: video)
      expect(user.queued_video?(video)).to be_truthy
    end
    it "returns fals when the user hasn't queued the video" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      expect(user.queued_video?(video)).to be_falsey
    end
  end

  describe "#follows?" do
    it "returns true if self has a following relationship with another user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      Fabricate(:relationship, leader: bob, follower: alice)
      expect(alice.follows?(bob)).to be_truthy
    end
    it "returns false if self does not have a following relationship with another user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      Fabricate(:relationship, leader: alice, follower: bob)
      expect(alice.follows?(bob)).to be_falsey
    end
  end

  describe '#can_follow?' do
    it "returns true if the current user is not the target user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      expect(alice.can_follow?(bob)).to be_truthy
    end
    it "returns true if the current user is not following the target user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      Fabricate(:relationship, follower: bob, leader: alice)
      expect(alice.can_follow?(bob)).to be_truthy
    end
    it "returns false if the current user is the target user" do
      alice = Fabricate(:user)
      expect(alice.can_follow?(alice)).to be_falsey
    end
    it "returns false if the current user is following the target user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      Fabricate(:relationship, follower: alice, leader: bob)
      expect(alice.can_follow?(bob)).to be_falsey
    end
  end

  describe '#follow' do
    it "follows another user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      alice.follow(bob)
      expect(alice.follows?(bob)).to be_truthy
    end
    it "does not follow oneself" do
      alice = Fabricate(:user)
      alice.follow(alice)
      expect(alice.follows?(alice)).to be_falsey
    end
  end
end