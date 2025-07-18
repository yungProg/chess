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

  def move_piece # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    puts "#{@current_player.name} please select a piece"
    selected_piece = nil
    selected_destination = nil
    loop do
      selected_piece = select_piece
      selected_destination = select_destination(selected_piece)
      break if selected_piece && selected_destination
    end
    @chessboard.board[selected_destination[0]][selected_destination[1]] =
      @chessboard.board[selected_piece[0]][selected_piece[1]]
    @chessboard.board[selected_piece[0]][selected_piece[1]] = Piece.new('', '')
  end

  def select_piece
    piece_selected = gets.chomp.downcase
    valid_piece = verify_selected_position(piece_selected)
    return valid_piece if valid_piece

    puts 'Invalid selection! Please choose valid piece'
  end

  def select_destination(start)
    puts "#{@current_player.name} please choose destination"
    selected_destination = gets.chomp.downcase
    valid_range = verify_range(selected_destination)
    verified_destination = verify_destination(start, valid_range)
    return valid_range if verified_destination

    puts 'Invalid destination! Please choose a piece to move'
  end

  def verify_selected_position(selected_position)
    selected_position = selected_position.downcase
    valid_cell = selected_position.match?(/^[a-h][1-8]$/)
    return nil unless valid_cell

    y = x_coordinate(selected_position)
    x = y_coordinate(selected_position)

    [x, y] if @chessboard.board[x][y].color == @current_player.color
  end

  def verify_range(player_input)
    valid_cell = player_input.match?(/^[a-h][1-8]$/)
    return nil unless valid_cell

    y = x_coordinate(player_input)
    x = y_coordinate(player_input)
    item = @chessboard.board[x][y]

    return [x, y] unless item.color == @current_player.color

    nil
  end

  def verify_destination(start, destination)
    return nil if start.nil?

    piece = @chessboard.board[start[0]][start[1]]

    piece.valid_moves.include?(destination)
  end

  def turn_player
    @current_player = if @current_player == @player1
                        @player2
                      else
                        @player1
                      end
  end
end
