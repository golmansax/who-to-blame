module WhoToBlame
  class SnapshotsController < WhoToBlame::ApplicationController
    def show
      date = date_from_params

      footprints = db_manager.footprints(date)
      snapshot = WhoToBlame::Snapshot.new(date, footprints)

      respond_to do |format|
        format.json { render json: snapshot }
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
        format.json { render json: snapshots.last }
      end
    end

    private

    def date_from_params
      Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
    end

    def asking_for_latest
      params[:id] == 'latest'
    end
  end
end
