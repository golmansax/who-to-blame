module WhoToBlame
  class FileType < ActiveRecord::Base
    has_many :footprints, dependent: :destroy
  end
end
