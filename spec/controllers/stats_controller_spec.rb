require 'spec_helper'

describe WhoToBlame::StatsController, '#index' do
  it 'assigns @stats' do
    get(:index, use_route: :who_to_blame)
    expect(assigns[:stats]).not_to be_nil
  end
end
