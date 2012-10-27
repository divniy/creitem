FactoryGirl.define do
  factory :product do
    title "Awesome item"
    description Faker::Lorem.paragraph(5)
    price { rand(100..10000) }

    trait(:updated_title) { title "Updated item" }
  end
  factory :invalid_product, parent: :product do
    title nil
    description nil
    price 0
  end
end