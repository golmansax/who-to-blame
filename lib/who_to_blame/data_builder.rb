module WhoToBlame
  class DataBuilder
    attr_accessor :file_types

    def initialize(file_types)
      self.file_types = file_types
    end

    # Unit of step is in days
    def snapshots(end_date, num_steps, step = 1)
      start_date = end_date - num_steps * step

      (0..num_steps * step).step(step).map do |num_days_in_past|
        date = start_date + num_days_in_past
        WhoToBlame::Snapshot.new(date, footprints(date))
      end
    end

    def footprints(date)
      file_types.reduce([]) do |memo, file_type|
        memo + extract_footprints(date, file_type)
      end
    end

    private

    def extract_footprints(date, file_type)
      lines_per_author(date, file_type).map do |author, num_lines|
        WhoToBlame::BasicFootprint.new(author, file_type, num_lines)
      end
    end

    def lines_per_author(date, file_type)
      result = WhoToBlame::BashInterface.new.who_to_blame_for(date, file_type)

      result.split("\n").each_with_object({}) do |line, memo|
        captures = line.match('^\s*(\d*) author (.*)$').captures
        authors = parse_authors(captures.last)
        authors.each do |author|
          memo[author] = 0 if memo[author].nil?
          memo[author] += captures.first.to_i
        end
      end
    end

    def parse_authors(input)
      input.split(' + ').reject do |author|
        author.downcase == 'not committed yet'
      end
    end
  end
end
