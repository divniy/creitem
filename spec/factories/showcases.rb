# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :showcase, aliases: [:dummy_showcase] do
    title { Faker::Lorem.words(3).join(' ').capitalize }
    
    trait(:with_description) { description { Faker::Lorem.paragraph(5) } }

    factory :complete_showcase do
      with_description
      state "complete"
    end

    factory :active_showcase do
      with_description
      state "active"
    end
  end
end
