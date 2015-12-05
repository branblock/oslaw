FactoryGirl.define do
  factory :post do
    title "This is a factory post"
    body "This is a factory post. Posts must be at least twenty-five characters in length to be valid."
    association :user, factory: :standard_user, strategy: :build
  end
end
