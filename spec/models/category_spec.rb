require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { FactoryGirl.create(:category) }

  it { should have_many(:posts) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:user) }
  it { should validate_length_of(:name).is_at_least(5) }
  it { should validate_length_of(:name).is_at_most(25) }
  it { should validate_length_of(:description).is_at_least(5) }
  it { should validate_length_of(:description).is_at_most(100) }

  describe "attributes" do
    it "should respond to name" do
      expect(category).to respond_to(:name)
    end

    it "should respond to description" do
      expect(category).to respond_to(:description)
    end
  end
end
