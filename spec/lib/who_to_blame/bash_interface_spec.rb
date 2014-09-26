require 'spec_helper'

module WhoToBlame
  describe BashInterface do
    let(:interface) { BashInterface.new }

    describe '#commit_at' do
      it 'returns a hash for today' do
        expect(interface.commit_at(Date.today)).to match(/^[0-9a-f]*$/)
      end

      it 'returns a specified hash for 07/06/2014' do
        expected_hash = '0f02e346fcfcf4c3a139b04577ff4ba8739c376f'
        expect(interface.commit_at('07/06/2014')).to eq(expected_hash)
      end

      it 'returns nil for before the project started' do
        expect(interface.commit_at('06/04/2014')).to be_nil
      end
    end
  end
end
