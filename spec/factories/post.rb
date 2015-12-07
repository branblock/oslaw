FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.words(num = 2) }
    body { Faker::Lorem.sentence(word_count = 5) }
    user
    category
    # association :user, factory: :user, strategy: :build
    # association :category, factory: :category, strategy: :build
  end
end
