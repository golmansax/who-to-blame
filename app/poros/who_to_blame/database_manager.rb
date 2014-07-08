module WhoToBlame
  class DatabaseManager
    def stats
      FileType.all.each_with_object({}) do |file_type, memo|
        memo[file_type.name] = lines_per_author(file_type)
      end
    end

    def clear!
      Author.destroy_all
      FileType.destroy_all
      self
    end

    # Stats should be a hash from file_type => lines_per_author
    def load!(stats)
      stats.each do |file_type_name, lines_per_author|
        file_type = FileType.find_or_create_by_name!(file_type_name)

        lines_per_author.each do |author_name, num_lines|
          author = Author.find_or_create_by_full_name!(author_name)
          params = { num_lines: num_lines, date: Date.today }
          Footprint.create_for_author_and_file_type!(author, file_type, params)
        end
      end
      self
    end

    private

    def lines_per_author(file_type)
      file_type.footprints.each_with_object({}) do |footprint, memo|
        memo[footprint.author.full_name] = footprint.num_lines
      end
    end
  end
end
