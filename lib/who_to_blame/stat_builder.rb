module WhoToBlame
  class StatBuilder
    attr_accessor :file_types

    def initialize(file_types)
      self.file_types = file_types
    end

    # Unit of step is in days
    # def stats_over_time(num_steps, step = 1)
    #   (0..num_steps * step).step(step).each do |num_days_in_past|
    #   end
    # end

    def stats
      file_types.each_with_object({}) do |file_type, memo|
        memo[file_type] = lines_per_author(file_type)
      end
    end

    private

    def lines_per_author(file_type)
      result = WhoToBlame::BashInterface.new.stats(file_type)

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
