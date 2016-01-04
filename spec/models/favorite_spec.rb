require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:post) { FactoryGirl.create(:post, user: user) }
  let(:favorite) { FactoryGirl.create(:favorite, post: my_post, user: user) }

  it { should belong_to(:post) }
  it { should belong_to(:user) }

  describe "favorite_for(post)" do
    it "returns `nil` if the user has not favorited the post" do
      @post = FactoryGirl.create(:post, user: user)
      expect(user.favorite_for(@post)).to be_nil
    end

    it "returns the appropriate favorite if it exists" do
      @post = FactoryGirl.create(:post, user: user)
      favorite = user.favorites.where(post: @post).create
      expect(user.favorite_for(@post)).to eq(favorite)
    end
  end
end
