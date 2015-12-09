FactoryGirl.define do
  factory :category do
    name { Faker::Lorem.characters(10) }
    description { Faker::Lorem.sentence(word_count = 2) }
    user
  end
end
