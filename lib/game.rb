# frozen_string_literal: true

require_relative 'chessboard'
require_relative 'player'
require 'colorize'

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
    colors = [:light_cyan, :light_magenta]
    8.downto(1) do |i|
      print "#{i} "
      chessboard[i - 1].each do |field| 
        print " #{field}  ".colorize(:background => colors[0])
        colors.rotate!
      end 
      colors.rotate!
      print " #{i}\n"
    end
  end
end

gg = Game.new
gg.display_board
