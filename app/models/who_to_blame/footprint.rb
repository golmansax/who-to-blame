module WhoToBlame
  class Footprint < ActiveRecord::Base
    attr_accessible :num_lines, :date, :file_type, :author
    belongs_to :author
    belongs_to :file_type
    validates :author, presence: true
    validates :file_type, presence: true
    validates :date, presence: true
    validates :num_lines, presence: true

    def self.create_for_author_and_file_type!(author, file_type, params = {})
      footprint = author.footprints.create!(params.merge(file_type: file_type))
      file_type.footprints << footprint
    end
  end
end
