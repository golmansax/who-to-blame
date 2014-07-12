require 'spec_helper'

module WhoToBlame
  describe StatBuilder do
    let(:builder) { StatBuilder.new(['rb']) }

    describe '#stats' do
      it 'returns a hash from file extensions to lines per author' do
        # Because this method takes a while, throw all of the expects in here

        stats = builder.stats
        expect(stats.keys).to eq(['rb'])

        stats.each do |_, lines_per_author|
          lines_per_author.each do |name, num_lines|
            expect(name).to be_instance_of(String)
            expect(num_lines).to be_a(Integer)
          end
        end
      end

      it 'breaks up multiple authors' do
        stats_from_bash = [
          '100 author Barney',
          '200 author Barney + Friends',
        ].join("\n")
        receive_expected = receive(:stats).and_return(stats_from_bash)
        expect_any_instance_of(BashInterface).to receive_expected

        expect(builder.stats['rb']).to eq('Barney' => 300, 'Friends' => 200)
      end

      it "doesn't allow 'Not Committed Yet' as an author" do
        stats_from_bash = [
          '100 author Barney',
          '200 author Not Committed Yet',
        ].join("\n")
        receive_expected = receive(:stats).and_return(stats_from_bash)
        expect_any_instance_of(BashInterface).to receive_expected

        expect(builder.stats['rb']).to eq('Barney' => 100)
      end
    end
  end
end
