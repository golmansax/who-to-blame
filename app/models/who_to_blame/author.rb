module WhoToBlame
  class Author < ActiveRecord::Base
    has_many :footprints, dependent: :destroy
  end
end
