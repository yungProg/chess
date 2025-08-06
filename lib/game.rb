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

  def display_board(selected_piece)
    chessboard = @chessboard.board
    colors = [:light_yellow, :light_magenta]
    board = @chessboard.board
    move_to = board[selected_piece[0]][selected_piece[1]].valid_moves(board)
    color_area(board, selected_piece, move_to, colors)
  end

  def color_area(board, selected_piece, move_to, colors)
    8.downto(1) do |i|
      print "#{i} "
      board[i - 1].each_with_index do |field, index|
        if move_to.include?([i - 1, index])
          print " #{field}  ".colorize(:background => :red)
        elsif selected_piece == [i - 1, index]
          print " #{field}  ".colorize(:background => :green)
        else
          print " #{field}  ".colorize(:background => colors[0])
        end
        colors.rotate!
      end 
      colors.rotate!
      print " #{i}\n"
    end
  end
end
