# frozen_string_literal: true

require_relative 'chessboard'
require_relative 'player'
require_relative '../pieces/piece'
require 'colorize'

# Defines game flow
class Game
  def initialize
    @player1 = Player.new('white')
    @player2 = Player.new('black')
    @chessboard = ChessBoard.new
    @current_player = @player1
  end

  def move_piece
    move_from = verify_selected_piece
    possible_destinations = @chessboard.board[move_from[0]][move_from[1]].valid_moves(@chessboard.board)
    move_to = verify_destination(possible_destinations)
    @chessboard.board[move_to[0]][move_to[1]] = @chessboard.board[move_from[0]][move_from[1]]
    @chessboard.board[move_from[0]][move_from[1]] = Piece.new(nil, '')
  end

  def verify_selected_piece
    loop do
      player_choice = @current_player.take_input
      return player_choice if @chessboard.board[player_choice[0]][player_choice[1]].color == @current_player.color

      puts 'Please select a piece belonging to you!'
    end
  end

  def verify_destination(legal_destinations)
    loop do
      player_choice = @current_player.take_input
      return player_choice if legal_destinations.include?(@chessboard.board[player_choice[0]][player_choice[1]])

      puts 'Invalid destination'
    end
  end

  def king_checked?
    king_position = @chessboard.find_king(@current_player.color)
    @current_player.color == 'white' ? color = 'black' : color = 'white'
    opponent_pieces = @chessboard.board.flatten.filter { |piece| piece.color == color}
    opponent_pieces.any? { |piece| piece.valid_moves(@chessboard.board).include?(king_position)}
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
