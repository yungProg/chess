# frozen_string_literal: true

require 'colorize'
require_relative '../piece/bishop'
require_relative '../piece/king'
require_relative '../piece/knight'
require_relative '../piece/pawn'
require_relative '../piece/queen'
require_relative '../piece/rook'
require_relative '../piece/piece'

# represents chess board
class Board
  attr_accessor :board

  def initialize # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    @board = [
      [Rook.new('black', 'a8'), Knight.new('black', 'b8'), Bishop.new('black', 'c8'), Queen.new('black', 'd8'),
       King.new('black', 'e8'), Bishop.new('black', 'f8'), Knight.new('black', 'g8'), Rook.new('black', 'h8')],
      [Pawn.new('black', 'a7'), Pawn.new('black', 'b7'), Pawn.new('black', 'c7'), Pawn.new('black', 'd7'),
       Pawn.new('black', 'e7'), Pawn.new('black', 'f7'), Pawn.new('black', 'g7'), Pawn.new('black', 'h7')],
      Array.new(8, Piece.new('', '')),
      Array.new(8, Piece.new('', '')),
      Array.new(8, Piece.new('', '')),
      Array.new(8, Piece.new('', '')),
      [Pawn.new('white', 'a2'), Pawn.new('white', 'b2'), Pawn.new('white', 'c2'), Pawn.new('white', 'd2'),
       Pawn.new('white', 'e2'), Pawn.new('white', 'f2'), Pawn.new('white', 'g2'), Pawn.new('white', 'h2')],
      [Rook.new('white', 'a1'), Knight.new('white', 'b1'), Bishop.new('white', 'c1'), Queen.new('white', 'd1'),
       King.new('white', 'e1'), Bishop.new('white', 'f1'), Knight.new('white', 'g1'), Rook.new('white', 'h1')]
    ]
  end

  def render_board
    print "   a   b   c   d   e   f   g   h\n"
    0.upto(7) do |i|
      print "#{(i - 8).abs} "
      @board[i].each { |cell| print " #{cell}  ".colorize(background: :blue) }
      print " #{(i - 8).abs}\n"
    end
    print "   a   b   c   d   e   f   g   h\n"
  end
end
