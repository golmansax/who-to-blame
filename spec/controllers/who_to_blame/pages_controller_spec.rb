require 'spec_helper'

module WhoToBlame
  describe PagesController do
    routes { WhoToBlame::Engine.routes }

    describe 'routing' do
      it 'creates route for index' do
        expect(get: '/').to route_to(
          controller: 'who_to_blame/pages',
          action: 'index',
        )
      end
    end

    describe '#index' do
      let!(:footprint) { create(:footprint) }

      before(:each) do
        get(:index)
      end

      it 'sets authors in gon' do
        expect(controller.gon.authors).to eq [footprint.author]
      end

      it 'sets dates in json' do
        date = footprint.date
        date_hash = { year: date.year, month: date.month, day: date.day }
        expect(controller.gon.dates).to eq [date_hash]
      end
    end
  end
end
