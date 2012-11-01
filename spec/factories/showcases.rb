# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :showcase do
    title { Faker::Lorem.words(3).join(' ').capitalize}

    trait(:dummy) { state "dummy" }
    trait(:prepared) { state "prepared" }
    trait(:active) { state "active" }

    factory :complete_showcase do
      description { Faker::Lorem.paragraph(5) }
    end
  end
end
