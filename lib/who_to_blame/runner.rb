module WhoToBlame
  class Runner
    def print_stats(my_file_type)
      builder = WhoToBlame::StatBuilder.new([my_file_type])
      stats = builder.stats
      stats.each do |file_type, lines_per_author|
        puts "Stats for #{file_type} files:"
        lines_per_author.each do |author, num_lines|
          puts "  #{author}: #{num_lines} lines"
        end
      end
    end
  end
end
