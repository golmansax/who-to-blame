# Read about factories at https://github.com/thoughtbot/factory_girl

module WhoToBlame
  FactoryGirl.define do
    factory :file_type, class: FileType do
      name 'rb'
      initialize_with { FileType.find_or_create_by_name!(name) }
    end
  end
end
