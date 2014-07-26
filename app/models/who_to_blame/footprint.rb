module WhoToBlame
  class Footprint < ActiveRecord::Base
    attr_accessible :num_lines, :date, :file_type, :author
    belongs_to :author
    belongs_to :file_type
    validates :author, presence: true
    validates :file_type, presence: true
    validates :date, presence: true
    validates :num_lines, presence: true

    def as_json(*)
      BasicFootprint.new(author.full_name, file_type.name, num_lines).as_json
    end
  end
end
