module WhoToBlame
  class FileType < ActiveRecord::Base
    attr_accessible :name
    has_many :footprints, dependent: :destroy
    validates :name, presence: true, uniqueness: { case_sensitive: false }

    before_save :downcase_name!

    def self.find_or_create_by_name!(my_name)
      file_type = find_by_name(my_name)
      file_type || create!(name: my_name.dup)
    end

    private

    def downcase_name!
      name.downcase!
    end
  end
end
