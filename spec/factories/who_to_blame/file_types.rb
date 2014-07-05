# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :file_type, class: WhoToBlame::FileType do
    name 'rb'
  end
end
