FactoryGirl.define do
  factory :product do
    title { Faker::Name.name_with_middle }
    price { Faker::Number.between(50, 100) }

    trait :price_100 do
      price 100
    end

    trait :price_200 do
      price 200
    end
  end
end

