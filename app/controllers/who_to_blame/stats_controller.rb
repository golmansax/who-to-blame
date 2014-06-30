module WhoToBlame
  class StatsController < WhoToBlame::ApplicationController
    def index
      builder = WhoToBlame::StatBuilder.new(['css'])
      @stats = builder.stats
    end
  end
end
