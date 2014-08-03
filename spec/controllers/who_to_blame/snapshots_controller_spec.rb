require 'spec_helper'

module WhoToBlame
  describe SnapshotsController do
    routes { WhoToBlame::Engine.routes }

    let(:params) { { format: :json } }
    let!(:snapshot) { create(:snapshot) }

    describe 'routing' do
      it 'creates route for snapshots at a date' do
        expect(get: '/snapshots/2014/30/05').to route_to(
          controller: 'who_to_blame/snapshots',
          action: 'index',
          year: '2014',
          day: '30',
          month: '05',
        )
      end
    end

    describe '#index' do
      it 'raises error if type is not json' do
        expect do
          get(:index, params.except(:format))
        end.to raise_error(ActionController::UnknownFormat)
      end

      it 'renders a json of the snapshot of today' do
        create(:snapshot, date: Date.today)
        get(:index, params)

        expected_footprint = {
          author: 'Scooby Doo',
          file_type: 'rb',
          num_lines: 20,
        }.with_indifferent_access
        snapshot =
        expect(JSON.parse(response.body)).to eq([expected_snapshot])
      end

      it 'gets associated stats with a date when params specified' do
        create(:snapshot, num_lines: 42, date: Date.new(2014, 05, 30))
        get(:index, params.merge(year: '2014', day: '30', month: '05'))

        expected_snapshot = {
          author: 'Scooby Doo',
          file_type: 'rb',
          num_lines: 42,
        }.with_indifferent_access
        expect(JSON.parse(response.body)).to eq([expected_snapshot])
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

      it 'renders a json of the basic snapshots and loads stats into db' do
        expected_output = [
          {
            year: 2014,
            month: 7,
            day: 4,
            snapshots: [holmans_ruby_snapshot(408).as_json],
          }.with_indifferent_access,
          {
            year: 2014,
            month: 7,
            day: 6,
            snapshots: [holmans_ruby_snapshot(567).as_json],
          }.with_indifferent_access,
          {
            year: 2014,
            month: 7,
            day: 8,
            snapshots: [holmans_ruby_snapshot(812).as_json],
          }.with_indifferent_access,
        ]

        post(:create, create_params)
        rendered_json = JSON.parse(response.body)
        expect(rendered_json).to eq(expected_output)

        expect(Author.find_by_full_name('Holman Gao')).not_to be_nil
        expect(FileType.all.map(&:name)).to eq(['rb'])
        expect(snapshot.count).to be > 0
      end
    end

    def holmans_ruby_snapshot(num_lines)
      Basicsnapshot.new('Holman Gao', 'rb', num_lines)
    end
  end
end
