FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.characters(10) }
    body { Faker::Lorem.sentence(word_count = 5) }
    user

    trait :tagged do
      after(:create) { |post| post.update_attributes(tag_list: 'tag') }
    end
  end
end
