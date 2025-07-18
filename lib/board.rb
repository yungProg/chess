# frozen_string_literal: true

require_relative '../piece/bishop'
require_relative '../piece/king'
require_relative '../piece/knight'
require_relative '../piece/pawn'
require_relative '../piece/queen'
require_relative '../piece/rook'

# represents chess board
class Board
  def initialize
    @board = [
      [Rook.new('black', 'a8'), Knight.new('black', 'b8'), Bishop.new('black', 'c8'), Queen.new('black', 'd8'),
       King.new('black', 'e8'), Bishop.new('black', 'f8'), Knight.new('black', 'g8'), Rook.new('black', 'h8')],
      [Pawn.new('black', 'a7'), Pawn.new('black', 'b7'), Pawn.new('black', 'c7'), Pawn.new('black', 'd7'),
       Pawn.new('black', 'e7'), Pawn.new('black', 'f7'), Pawn.new('black', 'g7'), Pawn.new('black', 'h7')],
      Array.new(8, '.'), Array.new(8, '.'), Array.new(8, '.'), Array.new(8, '.'),
      [Pawn.new('white', 'a2'), Pawn.new('white', 'b2'), Pawn.new('white', 'c2'), Pawn.new('white', 'd2'),
       Pawn.new('white', 'e2'), Pawn.new('white', 'f2'), Pawn.new('white', 'g2'), Pawn.new('white', 'h2')],
      [Rook.new('white', 'a1'), Knight.new('white', 'b1'), Bishop.new('white', 'c1'), Queen.new('white', 'd1'),
       King.new('white', 'e1'), Bishop.new('white', 'f1'), Knight.new('white', 'g1'), Rook.new('white', 'h1')]
    ]
  end

  def render_board
    print "   a   b   c   d   e   f   g   h\n"
    7.downto(0) do |i|
      print "#{i + 1} "
      @board[i].each { |cell| print " #{cell}  " }
      print "#{i + 1}\n"
    end
    print "   a   b   c   d   e   f   g   h\n"
  end
end

Board.new.render_board
