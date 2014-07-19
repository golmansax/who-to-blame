module WhoToBlame
  class FootprintsController < WhoToBlame::ApplicationController
    def index
      respond_to do |format|
        format.json { render json: DatabaseManager.new.stats }
      end
    end

    def create
      stats = WhoToBlame::StatBuilder.new(['rb']).stats_at(Date.today)
      DatabaseManager.new.clear!.load!(stats)

      respond_to do |format|
        format.json { render json: stats }
      end
    end
  end
end
