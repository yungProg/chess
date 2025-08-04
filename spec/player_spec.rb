# frozen_string_literal: true

require_relative '../lib/player'

describe Player do # rubocop:disable Metrics/BlockLength
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
    subject(:input_loop) { described_class.new('white') }
    context 'when player enters valid input' do
      it 'returns movement coordinates without error message' do
        valid_input = 'a7a6'
        allow(input_loop).to receive(:gets).and_return(valid_input)
        expect(input_loop.take_input).to eq([[1, 0], [2, 0]])
      end
    end
    context 'when player enters invalid input then valid input' do
      before do
        invalid_input = 'a7i6'
        valid_input = 'a7a6'
        call_to_action = 'Move piece'
        allow(input_loop).to receive(:gets).and_return(invalid_input, valid_input)
        allow(input_loop).to receive(:puts).with(call_to_action)
      end
      it 'returns movement coordinates after one error message' do
        error_message = 'Invalid range!'
        expect(input_loop).to receive(:puts).with(error_message).once
        input_loop.take_input
      end
    end
  end
end
