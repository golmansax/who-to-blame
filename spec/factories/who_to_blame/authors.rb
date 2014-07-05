# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :author, class: WhoToBlame::Author do
    full_name 'Scooby Doo'
  end
end
