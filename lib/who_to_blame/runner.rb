module WhoToBlame

  class Runner

    def print_stats(file_extension)
      builder = WhoToBlame::StatBuilder.new([file_extension])
      stats = builder.stats
      stats.each do |file_extension, lines_per_author|
        puts "Stats for #{file_extension} files:"
        lines_per_author.each do |author, num_lines|
          puts "  #{author}: #{num_lines} lines"
        end
      end
    end

  end

end
