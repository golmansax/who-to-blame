require 'spec_helper'

module WhoToBlame
  describe FileType do
    describe 'associations' do
      it { should have_many(:footprints).dependent(:destroy) }
    end

    it 'enforces unique case insensitive full names' do
      FileType.create!(name: 'rb')
      expect do
        FileType.create!(name: 'Rb')
      end.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'forces name to be downcase' do
      file_type = FileType.create!(name: 'Rb')
      expect(file_type.name).to eq 'rb'
    end
  end
end
