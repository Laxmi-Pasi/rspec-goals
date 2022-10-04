FactoryBot.define do
  factory :project do
    project_name { Faker::Name.name }
    project_status { 'open' }
    association :user
  end
end
