require_relative '../pieces/piece.rb'

describe Piece do
  subject(:game_piece) { described_class.new('white') }
  describe '#initialize' do
    context 'when new piece is created' do
      it 'has color' do
        piece_color = game_piece.color
        expect(piece_color).to eq('white')
      end
    end
  end
end