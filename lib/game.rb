# frozen_string_literal: true

require_relative 'chessboard'
require_relative 'player'

# Defines game flow
class Game
  def initialize
    @player1 = Player.new('white')
    @player2 = Player.new('black')
    @chessboard = ChessBoard.new
    @current_player = @player1
  end

  def display_board
    chessboard = @chessboard.board
    8.downto(1) do |i|
      print "#{i} "
      chessboard[i - 1].each { |field| print " #{field} " }
      print " #{i}\n"
    end
  end
end

gg = Game.new
gg.display_board
