require 'spec_helper'

module WhoToBlame
  describe SnapshotsController do
    routes { WhoToBlame::Engine.routes }

    let(:params) { { format: :json } }
    let!(:footprint) { create(:footprint) }

    describe 'routing' do
      it 'creates route for snapshot at a date' do
        expect(get: '/snapshots/2014/30/05').to route_to(
          controller: 'who_to_blame/snapshots',
          action: 'show',
          year: '2014',
          day: '30',
          month: '05',
        )
      end

      it 'creates route for latest snapshot' do
        expect(get: '/snapshots/latest').to route_to(
          controller: 'who_to_blame/snapshots',
          action: 'show',
          id: 'latest',
        )
      end
    end

    describe '#show' do
      let(:show_params) { params.merge(year: '2014', day: '30', month: '05') }
      it 'raises error if type is not json' do
        expect do
          get(:show, show_params.except(:format))
        end.to raise_error(ActionController::UnknownFormat)
      end

      it 'renders a json of the snapshot of today' do
        create(:footprint, date: Date.today)
        get(:show, params.merge(id: 'latest'))

        expected_footprint = {
          author: 'Scooby Doo',
          file_type: 'rb',
          num_lines: 20,
        }.with_indifferent_access

        snapshot = JSON.parse(response.body)
        expect(snapshot['footprints']).to eq([expected_footprint])
      end

      it 'gets associated stats with a date when params specified' do
        create(:footprint, num_lines: 42, date: Date.new(2014, 05, 30))
        get(:show, show_params)

        expected_footprint = {
          author: 'Scooby Doo',
          file_type: 'rb',
          num_lines: 42,
        }.with_indifferent_access
        snapshot = JSON.parse(response.body)
        expect(snapshot['footprints']).to eq([expected_footprint])
      end
    end

    describe '#create' do
      let(:create_params) do
        params.merge(
          year: '2014',
          month: '07',
          day: '08',
          num_steps: 2,
          step: 2,
        )
      end

      it 'raises error if type is not json' do
        expect do
          post(:create, create_params.except(:format))
        end.to raise_error(ActionController::UnknownFormat)
      end

      it 'renders a json of latest snapshot and loads stats into db' do
        expected_snapshot = {
          year: 2014,
          month: 7,
          day: 8,
          footprints: [holmans_ruby_footprint(812).as_json],
        }.with_indifferent_access

        post(:create, create_params)
        rendered_json = JSON.parse(response.body)
        expect(rendered_json).to eq(expected_snapshot)

        expect(Author.find_by_full_name('Holman Gao')).not_to be_nil
        expect(FileType.all.map(&:name)).to eq(['rb'])

        start_date = Date.new(2014, 7, 4)
        expected_dates = [start_date, start_date + 2, start_date + 4]
        expect(Footprint.all.map(&:date)).to eq(expected_dates)

        expected_lines = [408, 567, 812]
        expect(Footprint.all.map(&:num_lines)).to eq(expected_lines)
      end
    end

    def holmans_ruby_footprint(num_lines)
      BasicFootprint.new('Holman Gao', 'rb', num_lines)
    end
  end
end
