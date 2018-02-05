FactoryGirl.define do
  factory :user do
    provider "abc"
    uid "abc"
    name "abc"
    email { |n| "user#{n}@gmail.com" }
    date_of_birth Date.today
    country
    city
    password "123456"
    password_confirmation "123456"
    confirmed_at Date.today
    after :create do |b|
      b.update_column(:avatar, "public/default_avatar.jpeg")
      b.update_column(:cover_photo, "public/default_cover_photo.jpg")
    end
  end

  factory :country do
    name { |n| "country#{n}" }
  end

  factory :city do
    country
    name { |n| "city#{n}" }
  end
end
