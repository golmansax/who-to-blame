module WhoToBlame
  class Author < ActiveRecord::Base
    attr_accessible :full_name
    has_many :footprints, dependent: :destroy
    validates :full_name, presence: true, uniqueness: { case_sensitive: false }

    def self.find_or_create_by_full_name!(full_name)
      author = find_by_full_name(full_name)
      author || create!(full_name: full_name)
    end

    def as_json(*)
      { id: id, full_name: full_name }
    end
  end
end
