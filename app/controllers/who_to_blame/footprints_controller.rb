module WhoToBlame
  class FootprintsController < WhoToBlame::ApplicationController
    def index
      date = params[:year] ? date_from_params : Date.today

      respond_to do |format|
        format.json { render json: DatabaseManager.new.stats_at(date) }
      end
    end

    def create
      num_steps = params[:num_steps].to_i
      step = params[:step].to_i
      end_date = date_from_params
      data_builder = WhoToBlame::DataBuilder.new(['rb'])
      snapshots = data_builder.snapshots(end_date, num_steps, step)
      DatabaseManager.new.clear!.load_snapshots!(snapshots)

      respond_to do |format|
        format.json { render json: snapshots }
      end
    end

    private

    def date_from_params
      Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
    end
  end
end
