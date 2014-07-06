# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :footprint, class: WhoToBlame::Footprint do
    author
    file_type
    date '2014-07-05'
    num_lines 20
  end
end
