FactoryGirl.define do
  factory :user do
    first_name            { Faker::Name.first_name }
    last_name             { Faker::Name.last_name }
    username              { Faker::Internet.user_name }
    email                 { Faker::Internet.email}
    password              "password"
    password_confirmation "password"
    role                  :standard
    confirmed_at Date.today

    factory :admin do
      role      :admin
    end
  end
end
