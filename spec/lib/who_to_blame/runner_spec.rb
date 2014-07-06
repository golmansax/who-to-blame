require 'spec_helper'

describe WhoToBlame::Runner, '#print_stats' do
  let(:runner) { WhoToBlame::Runner.new }
  it 'outputs stats' do
    expected_output = /Stats for rb files:\n.*Holman Gao: \d+ lines/
    expect { runner.print_stats('rb') }.to output(expected_output).to_stdout
  end
end
