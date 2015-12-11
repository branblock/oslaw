require 'rails_helper'

RSpec.describe Vote, type: :model do
  let(:category) { FactoryGirl.create(:category) }
  let(:user) { FactoryGirl.create(:user) }
  let(:post) { FactoryGirl.create(:post) }
  let(:comment) { FactoryGirl.create(:comment) }
  let(:vote) { FactoryGirl.create(:vote, user: user, post: post, comment: comment) }

  it { should belong_to(:user) }
  it { should belong_to(:post) }
  it { should belong_to(:comment) }
  it { should validate_presence_of(:value) }
  it { should validate_inclusion_of(:value).in_array([-1, 1]) }

  describe "update_post callback" do
    it "triggers update_post on save" do
      expect(vote).to receive(:update_post).at_least(:once)
      vote.save
    end

    it "#update_post should call update_rank on post" do
      expect(post).to receive(:update_rank).at_least(:once)
      vote.save
    end
  end
end
