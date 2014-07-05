module WhoToBlame
  class Footprint < ActiveRecord::Base
    belongs_to :author
    belongs_to :file_type
  end
end
