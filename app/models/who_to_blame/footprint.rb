module WhoToBlame
  class Footprint < ActiveRecord::Base
    belongs_to :author
    belongs_to :file_type

    def self.create_for_author_and_file_type!(author, file_type, params = {})
      footprint = author.footprints.create!(params)
      file_type.footprints << footprint
    end
  end
end
