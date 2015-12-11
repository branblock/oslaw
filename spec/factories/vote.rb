FactoryGirl.define do
  factory :vote do
    value { Faker::Number.between(-1, 1) }
    user
    post
    comment

    factory :up_vote do
      value 1
    end

    factory :down_vote do
      value -1
    end
  end
end
