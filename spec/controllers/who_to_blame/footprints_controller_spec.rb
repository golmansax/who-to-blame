require 'spec_helper'

module WhoToBlame
  describe FootprintsController do
    let(:params) { { use_route: :who_to_blame, format: :json } }
    let!(:footprint) { create(:footprint) }

    describe '#index' do
      it 'raises error if type is not json' do
        expect do
          get(:index, params.except(:format))
        end.to raise_error(ActionController::UnknownFormat)
      end

      it 'renders a json of the stats in the db' do
        get(:index, params)
        rendered_json = JSON.parse(response.body)
        expect(rendered_json.keys).to eq(['rb'])
        expect(rendered_json['rb'].keys).to eq(['Scooby Doo'])
      end
    end

    describe '#create' do
      it 'raises error if type is not json' do
        expect do
          post(:create, params.except(:format))
        end.to raise_error(ActionController::UnknownFormat)
      end

      it 'renders a json of the stats in the db and loads stats into db' do
        post(:create, params)
        rendered_json = JSON.parse(response.body)
        expect(rendered_json.keys).to eq(['rb'])
        expect(rendered_json['rb']).to have_key('Holman Gao')
        expect(Author.find_by_full_name('Holman Gao')).not_to be_nil
        expect(FileType.all.map(&:name)).to eq(['rb'])
        expect(Footprint.count).to be > 0
      end
    end
  end
end
