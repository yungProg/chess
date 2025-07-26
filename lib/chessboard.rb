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
    rank_num.each { |num| @board[num - 1] = pieces["rank#{num}".to_sym] }
  end

  private

  def assemble_white_pieces
    {
      rank1: [
        Rook.new('white'), Knight.new('white'), Bishop.new('white'), Queen.new('white'),
        King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')
      ],
      rank2: [Pawn.new('white')] * 8
    }
  end

  def assemble_black_pieces
    {
      rank7: [Pawn.new('black')] * 8,
      rank8: [
        Rook.new('black'), Knight.new('black'), Bishop.new('black'), Queen.new('black'),
        King.new('black'), Bishop.new('black'), Knight.new('black'), Rook.new('black')
      ]
    }
  end
end

p ChessBoard.new
