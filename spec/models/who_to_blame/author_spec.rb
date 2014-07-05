require 'spec_helper'

describe WhoToBlame::Author do
  describe 'associations' do
    it { should have_many(:footprints).dependent(:destroy) }
  end
end
