FactoryGirl.define do
  factory :category do
    name { Faker::Lorem.words(num = 1) }
    description { Faker::Lorem.sentence(word_count = 2) }
    user
  end
end
