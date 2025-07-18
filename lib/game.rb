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

  def rr
    @chessboard.render_board
  end

  def select_piece
    puts "#{@current_player.name} please select a piece"
    loop do
      piece_selected = gets.chomp.downcase
      valid_piece = verify_selected_position(piece_selected)
      return valid_piece if valid_piece
      puts 'Invalid selection'
    end
  end

  def move_piece
    piece_position = select_piece
    piece_selected = @chessboard.board[piece_position[0]][piece_position[1]]
    coord = nil
    loop do
      selected_destination = select_destination
      if piece_selected.valid_moves.include?(selected_destination)
        coord = selected_destination
        break
      end
    end
    @chessboard.board[coord[0]][coord[1]] = piece_selected
    @chessboard.board[coord[0]][coord[1]].update_postion(@chessboard.board[coord[0]][coord[1]])
    @chessboard.board[piece_position[0]][piece_position[1]] = Piece.new('', '')
  end

  def select_destination
    puts "#{@current_player.name} please choose destination"
    loop do
      selected_destination = gets.chomp.downcase
      valid_destination = verify_destination(selected_destination)
      return valid_destination if valid_destination
      puts 'Invalid destination'
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

  def verify_destination(destination)
    valid_cell = destination.match?(/^[a-h][1-8]$/)
    return nil unless valid_cell
    y = x_coordinate(destination)
    x = y_coordinate(destination)
    item = @chessboard.board[x][y]

    [x, y] if item.color == @current_player.color
  end

  def turn_player
    @current_player = if @current_player == @player1
                        @player2
                      else
                        @player1
                      end
  end
end

ng = Game.new('player1', 'player2')
ng.rr
ng.move_piece
ng.rr
