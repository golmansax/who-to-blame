module WhoToBlame
  class Footprint < ActiveRecord::Base
    attr_accessible :num_lines, :date, :file_type, :author
    belongs_to :author
    belongs_to :file_type
    validates :author, presence: true
    validates :file_type, presence: true
    validates :date, presence: true
    validates :num_lines, presence: true
  end
end
