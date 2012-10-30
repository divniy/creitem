# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :showcase do
    title "Test showcase"
    state "dummy"

    factory :prepared_showcase do
      description "Some text"
      state "prepared"
    end
  end
end
