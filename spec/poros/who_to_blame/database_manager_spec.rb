require 'spec_helper'

module WhoToBlame
  describe DatabaseManager do
    let(:manager) { DatabaseManager.new }

    describe '#clear!' do
      let!(:footprint) { create(:footprint) }

      before(:each) { manager.clear! }

      it 'clears authors' do
        expect(Author.count).to eq(0)
      end

      it 'clears file_types' do
        expect(FileType.count).to eq(0)
      end

      it 'clears footprints' do
        expect(Footprint.count).to eq(0)
      end
    end

    describe '#load!' do
      let(:stats) do
        {
          'rb' => { 'Scooby Doo' => 77, 'Shaggy' => 40 },
          'cpp' => { 'Scooby Doo' => 15, 'Velma' => 1 },
        }
      end

      before(:each) { manager.load!(stats) }

      it 'creates authors' do
        expected_names = ['Scooby Doo', 'Shaggy', 'Velma']
        expect(Author.all.map(&:full_name)).to eq(expected_names)
      end

      it 'creates file_types' do
        expected_names = %w(rb cpp)
        expect(FileType.all.map(&:name)).to eq(expected_names)
      end

      it 'creates footprints' do
        expected_num_lines = [77, 40, 15, 1]
        expect(Footprint.all.map(&:num_lines)).to eq(expected_num_lines)
      end
    end
  end
end
