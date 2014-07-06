require 'spec_helper'

module WhoToBlame
  describe Author do
    describe 'associations' do
      it { should have_many(:footprints).dependent(:destroy) }
    end

    it 'enforces unique case insensitive full names' do
      Author.create!(full_name: 'Holman')
      expect do
        Author.create!(full_name: 'holman')
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
