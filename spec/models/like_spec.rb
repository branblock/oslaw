require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:post) { FactoryGirl.create(:post) }
  let(:like) { FactoryGirl.create(:like, user: user, post: post) }

  it { should belong_to(:user) }
  it { should belong_to(:post) }
  it { should validate_presence_of(:value) }
  it { should validate_inclusion_of(:value).in_array([0, 1]) }

  describe "update_post callback" do
    it "triggers update_post on save" do
      expect(like).to receive(:update_post).at_least(:once)
      like.save
    end

    it "#update_post should call update_rank on post" do
      expect(post).to receive(:update_rank).at_least(:once)
      like.save
    end
  end
end
