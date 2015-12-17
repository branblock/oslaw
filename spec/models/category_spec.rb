require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:category) { FactoryGirl.create(:category, user: user) }

  it { should belong_to(:user) }
  it { should have_many(:posts) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:user) }

  describe "attributes" do
    it "should respond to name" do
      expect(category).to respond_to(:name)
    end

    it "should respond to description" do
      expect(category).to respond_to(:description)
    end
  end
end
