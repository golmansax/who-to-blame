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

    describe '#as_json' do
      let(:author) { create(:author) }

      it 'has :id' do
        expect(author.as_json[:id]).to eq author.id
      end

      it 'has :full_name' do
        expect(author.as_json[:full_name]).to eq author.full_name
      end
    end
  end
end
