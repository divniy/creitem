# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :showcase do
    title { Faker::Lorem.words(3).join(' ').capitalize}
    state "dummy"

    factory :prepared_showcase do
      description { Faker::Lorem.paragraph(5) }
      state "prepared"
    end

    factory :active_showcase, :parent => :prepared_showcase do
      state "active"
    end
  end
end
