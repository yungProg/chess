# frozen_string_literal: true

require_relative '../lib/chessboard'

describe ChessBoard do
  subject(:new_board) { described_class.new }
  describe '#initialize' do
    let(:ranks) { new_board.board.length }
    let(:files) { new_board.board.all? { |rank| rank.length == 8 } }
    context 'when new board is created' do
      it 'creates a board with 8 ranks' do
        no_ranks = 8
        expect(ranks).to eq(no_ranks)
      end
      it 'creates a board with 8 files' do
        expect(files).to be true
      end
      it 'there are chess pieces on the board' do
        first_rank = new_board.board[0]
        expect(first_rank.any?(&:nil?)).to be false
      end
    end
  end
end
