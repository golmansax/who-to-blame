require 'spec_helper'

module WhoToBlame
  describe DataBuilder do
    let(:builder) { DataBuilder.new(['rb']) }

    describe '#footprints' do
      it 'returns desired data from 07/04' do
        footprints = builder.footprints(Date.parse('07/04'))
        expect(footprints).to eq([BasicFootprint.new('Holman Gao', 'rb', 408)])
      end

      it 'breaks up multiple authors' do
        stats_from_bash = [
          '100 author Barney',
          '200 author Barney + Friends',
        ].join("\n")
        expect_any_instance_of(BashInterface).to receive(:who_to_blame_for)
          .with(Date.today, 'rb')
          .and_return(stats_from_bash)

        footprints = builder.footprints(Date.today)
        expect(footprints).to eq([
          BasicFootprint.new('Barney', 'rb', 300),
          BasicFootprint.new('Friends', 'rb', 200),
        ])
      end

      it "doesn't allow 'Not Committed Yet' as an author" do
        stats_from_bash = [
          '100 author Barney',
          '200 author Not Committed Yet',
        ].join("\n")
        expect_any_instance_of(BashInterface).to receive(:who_to_blame_for)
          .with(Date.today, 'rb')
          .and_return(stats_from_bash)

        footprints = builder.footprints(Date.today)
        expect(footprints).to eq([BasicFootprint.new('Barney', 'rb', 100)])
      end
    end
  end
end
