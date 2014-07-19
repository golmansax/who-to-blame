require 'spec_helper'

describe WhoToBlame::Runner, '#print_stats_at' do
  let(:runner) { WhoToBlame::Runner.new }
  it 'outputs stats' do
    header = "Stats for rb files on #{Date.today}:"
    expected_output = /#{header}\n.*Holman Gao: \d+ lines/

    expect do
      runner.print_stats_at(Date.today, 'rb')
    end.to output(expected_output).to_stdout
  end
end
