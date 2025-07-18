# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative '../helper/piece_coordinates'

# represents game flow
class Game
  include PieceCoordinates
  def initialize(player1, player2, board = Board.new)
    @player1 = Player.new(player1, 'white')
    @player2 = Player.new(player2, 'black')
    @chessboard = board
    @current_player = @player1
  end

  def select_piece
    puts "#{@current_player.name} please select a piece"
    loop do
      piece_selected = gets.chomp.downcase
      valid_piece = verify_selected_position(piece_selected)
      return valid_piece if valid_piece
    end
  end

  def verify_selected_position(selected_position)
    selected_position = selected_position.downcase
    valid_cell = selected_position.match?(/^[a-h][1-8]$/)
    return nil unless valid_cell
    
    y = x_coordinate(selected_position)
    x = y_coordinate(selected_position)

    return [x, y] if @chessboard.board[x][y].color == @current_player.color
  end

  def turn_player
    @current_player = if @current_player == @player1
                        @player2
                      else
                        @player1
                      end
  end
end
