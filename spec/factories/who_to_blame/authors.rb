# Read about factories at https://github.com/thoughtbot/factory_girl

module WhoToBlame
  FactoryGirl.define do
    factory :author, class: Author do
      full_name 'Scooby Doo'
      initialize_with { Author.find_or_create_by_full_name!(full_name) }
    end
  end
end
