require 'faker'

# User Factories
FactoryGirl.define do
  factory :user do
    first_name            { Faker::Name.first_name }
    last_name             { Faker::Name.last_name }
    username              { Faker::Internet.user_name }
    email                 { Faker::Internet.email }
    password              "password"
    password_confirmation "password"
    role                  :standard
    confirmed_at Date.today
    end

  factory :admin, class: User do
    first_name            "Admin"
    last_name             "User"
    username              "adminuser"
    email                 "admin@example.com"
    password              "password"
    password_confirmation "password"
    role                  :admin
    confirmed_at Date.today
  end

  factory :standard, class: User do
    first_name            "Stan"
    last_name             "User"
    username              "stanuser"
    email                 "standard@example.com"
    password              "password"
    password_confirmation "password"
    role                  :standard
    confirmed_at Date.today
  end
end

# Post Factories
FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.words(rand(2..10)).join(' ') }
    body { Faker::Lorem.paragraphs(rand(6..12)).join('\n') }
    association :user, factory: :user, strategy: :build

    trait :with_comments do
      after(:create) do |post, evaluator|
        # FactoryGirl.create_list(factory, number_of_items, factory_attrs)
        FactoryGirl.create_list(:comment, 10, post: post)
      end
    end
  end
end

# Comment Factories
FactoryGirl.define do
  factory :comment do
    body { Faker::Lorem.sentence(rand(5..10)).chomp('.') }
    association :user, factory: :user, strategy: :build
    association :post, factory: :post, strategy: :build
  end
end
