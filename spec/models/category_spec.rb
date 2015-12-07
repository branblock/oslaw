require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { create(:category) }

  it { should have_many(:posts) }

  describe "attributes" do
    it "should respond to name" do
      expect(category).to respond_to(:name)
    end

    it "should respond to description" do
      expect(category).to respond_to(:description)
    end
  end
end
