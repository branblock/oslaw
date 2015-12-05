FactoryGirl.define do
  factory :admin_user, class: User do
    first_name            "Admin"
    last_name             "User"
    username              "adminuser"
    email                 "admin@example.com"
    password              "password"
    password_confirmation "password"
    role                  :admin
    confirmed_at Date.today
  end

  factory :standard_user, class: User do
    first_name            "Standard"
    last_name             "User"
    username              "standarduser"
    email                 "standard@example.com"
    password              "password"
    password_confirmation "password"
    role                  :standard
    confirmed_at Date.today
  end
end
