require 'spec_helper'

describe WhoToBlame::Footprint do
  describe 'associations' do
    it { should belong_to(:author) }
    it { should belong_to(:file_type) }
  end
end
