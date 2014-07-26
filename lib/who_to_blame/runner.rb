module WhoToBlame
  class Runner
    def print_stats_at(date, my_file_type)
      builder = WhoToBlame::DataBuilder.new([my_file_type])
      footprints = builder.footprints(date)

      puts "Stats for #{my_file_type} files on #{date}:"
      footprints.each do |footprint|
        puts "  #{footprint.author}: #{footprint.num_lines} lines"
      end
    end
  end
end
