FactoryGirl.define do
  factory :comment do
    body "This is a factory comment."
    association :user, factory: :standard_user, strategy: :build
    association :post, factory: :post, strategy: :build
  end
end
