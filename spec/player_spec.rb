# frozen_string_literal: true

require_relative '../lib/player'

describe Player do
  describe '#verify_range' do
    subject(:player_input) { described_class.new('white') }
    context 'when player wants to move' do
      it 'returns movement coordinates if move is within range' do
        result = player_input.verify_range('a7a6')
        resultant_coordinates = [[1, 0], [2, 0]]
        expect(result).to eq(resultant_coordinates)
      end
      it 'returns nil if move is out of range' do
        result = player_input.verify_range('a7i6')
        expect(result).to be_nil
      end
    end
  end

  describe '#take_input' do
    subject { described_class.new('white') }
    context 'when player enters valid input' do
      it 'returns movement coordinates' do
        valid_input = 'd7d6'
      end
    end
  end
end
