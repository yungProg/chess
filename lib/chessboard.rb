# frozen_string_literal: true

require_relative '../pieces/rook'
require_relative '../pieces/knight'
require_relative '../pieces/bishop'
require_relative '../pieces/queen'
require_relative '../pieces/king'
require_relative '../pieces/pawn'

# Chessboard blueprint
class ChessBoard
  attr_reader :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
    arrange_pieces
  end

  def arrange_pieces
    pieces = assemble_white_pieces.merge(assemble_black_pieces)
    rank_num = [1, 2, 7, 8]
    rank_num.each { |num| @board[(num - 8).abs] = pieces["rank#{num}".to_sym] }
  end

  private

  def assemble_white_pieces
    {
      rank1: [
        Rook.new('white', 'a1'), Knight.new('white', 'b1'), Bishop.new('white', 'c1'), Queen.new('white', 'd1'),
        King.new('white', 'e1'), Bishop.new('white', 'f1'), Knight.new('white', 'g1'), Rook.new('white', 'h1')
      ],
      rank2: [Pawn.new('white', 'a2'), Pawn.new('white', 'b2'), Pawn.new('white', 'c2'), Pawn.new('white', 'd2'),
              Pawn.new('white', 'e2'), Pawn.new('white', 'f2'), Pawn.new('white', 'g2'), Pawn.new('white', 'h2')]
    }
  end

  def assemble_black_pieces
    {
      rank7: [Pawn.new('black', 'a7'), Pawn.new('black', 'b7'), Pawn.new('black', 'c7'), Pawn.new('black', 'd7'),
              Pawn.new('black', 'e7'), Pawn.new('black', 'f7'), Pawn.new('black', 'g7'), Pawn.new('black', 'h7')],
      rank8: [
        Rook.new('black', 'a8'), Knight.new('black', 'b8'), Bishop.new('black', 'c8'), Queen.new('black', 'd8'),
        King.new('black', 'e8'), Bishop.new('black', 'f8'), Knight.new('black', 'g8'), Rook.new('black', 'h8')
      ]
    }
  end
end
