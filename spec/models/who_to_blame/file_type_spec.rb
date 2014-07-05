require 'spec_helper'

describe WhoToBlame::FileType do
  describe 'associations' do
    it { should have_many(:footprints).dependent(:destroy) }
  end
end
