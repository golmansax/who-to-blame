module WhoToBlame
  class DatabaseManager
    def footprints(date)
      Footprint.includes([:author, :file_type]).where(date: date)
    end

    def most_recent_date
      Footprint.all.map(&:date).sort.last
    end

    def clear!
      Footprint.destroy_all
      Author.includes(:footprints).destroy_all
      FileType.includes(:footprints).destroy_all
      self
    end

    def load_snapshots!(snapshots)
      snapshots.each do |snapshot|
        load!(snapshot.date, snapshot.footprints)
      end
      self
    end

    def load!(date, basic_footprints)
      basic_footprints.each do |basic_footprint|
        file_type = FileType.find_or_create_by_name!(basic_footprint.file_type)
        author = Author.find_or_create_by_full_name!(basic_footprint.author)

        Footprint.create!(
          num_lines: basic_footprint.num_lines,
          date: date,
          file_type: file_type,
          author: author,
        )
      end
      self
    end
  end
end
