# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :showcase, aliases: [:dummy_showcase] do
    title { Faker::Lorem.words(3).join(' ').capitalize }
    
    trait(:dummy) { state "dummy" }
    trait(:complete) { state "complete" }
    trait(:active) { state "active" }

    factory :complete_showcase do
      description { Faker::Lorem.paragraph(5) }
      complete
    end

    factory :active_showcase do
      description { Faker::Lorem.paragraph(5) }
      active
    end
  end
end
