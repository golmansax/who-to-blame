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
  end
end
