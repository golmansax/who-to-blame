require 'spec_helper'

describe WhoToBlame::StatBuilder, '#stats' do
  let(:builder) { WhoToBlame::StatBuilder.new(['rb']) }

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
end
