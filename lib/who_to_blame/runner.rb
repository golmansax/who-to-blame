module WhoToBlame
  class Runner
    def print_stats_at(date, my_file_type)
      builder = WhoToBlame::StatBuilder.new([my_file_type])
      stats = builder.stats_at(date)
      stats.each do |file_type, lines_per_author|
        puts "Stats for #{file_type} files on #{date}:"
        lines_per_author.each do |author, num_lines|
          puts "  #{author}: #{num_lines} lines"
        end
      end
    end
  end
end
