# frozen_string_literal: true

require_relative 'chessboard'
require_relative 'player'
require_relative '../pieces/piece'
require 'colorize'

# Defines game flow
class Game # rubocop:disable Metrics/ClassLength
  attr_reader :chessboard

  def initialize
    @player1 = Player.new('white')
    @player2 = Player.new('black')
    @chessboard = ChessBoard.new
    @current_player = @player1
  end

  def play
    display_board
    loop do
      puts "#{@current_player.color} your turn"
      move_piece
      display_board
      break if checkmate?(@current_player.color)

      turn_player
    end
    puts "#{@current_player.color} won"
    replay?
  end

  def move_piece # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    loop do
      move_from = verify_selected_piece
      display_board(move_from)
      possible_destinations = @chessboard.board[move_from[0]][move_from[1]].valid_moves(@chessboard.board)
      move_to = verify_destination(possible_destinations)
      piece_copy = @chessboard.board[move_from[0]][move_from[1]]
      destination_copy = @chessboard.board[move_to[0]][move_to[1]]
      @chessboard.board[move_to[0]][move_to[1]] = @chessboard.board[move_from[0]][move_from[1]]
      @chessboard.board[move_from[0]][move_from[1]] = Piece.new(nil, '')
      unless king_checked?(@current_player.color)
        @chessboard.board[move_to[0]][move_to[1]].update_position(move_to)
        return
      end
      puts "#{@current_player.color}: Move exposes your king! Try another"
      @chessboard.board[move_from[0]][move_from[1]] = piece_copy
      @chessboard.board[move_to[0]][move_to[1]] = destination_copy
    end
    # temporarily move the piece
    # check if it puts the king under check?
    # confirm move if it doesn't but revert if it does
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

  def king_checked?(color)
    king_position = @chessboard.find_king(color)
    opponent_color = color == 'white' ? 'black' : 'white'
    opponent_pieces = @chessboard.board.flatten.filter { |piece| piece.color == opponent_color }
    opponent_pieces.any? { |piece| piece.valid_moves(@chessboard.board).include?(king_position) }
  end

  def checkmate?(color)
    return true unless friend_intercede?(color) && capture_threatening_piece?(color) && king_escape?

    false
  end

  def checking_piece(color)
    # checking_pieces = []
    opponent_color = color == 'white' ? 'black' : 'white'
    king_position = @chessboard.find_king(opponent_color)
    player_pieces = @chessboard.board.flatten.filter { |piece| piece.color == color }
    player_pieces.each do |piece|
      # return piece.position_to_array_index if piece.valid_moves(@chessboard.board).include?(king_position)

      return piece if piece.valid_moves(@chessboard.board).include?(king_position)
    end
    # checking_pieces
  end

  def king_escape?
    # check if opponent king is checked
    # return nil if it's not
    # if it's checked, check if it can move out of check
    # also check if another piece can protect the king
    opponent_color = @current_player.color == 'white' ? 'black' : 'white'
    return true unless king_checked?(opponent_color)

    king_position = @chessboard.find_king(opponent_color)
    king_movements = @chessboard.board[king_position[0]][king_position[1]].valid_moves(@chessboard.board)
    all_player_moves = @chessboard.all_moves(@current_player.color).flatten(0)
    true unless king_movements.all? { |move| all_player_moves.include?(move) }
  end

  def capture_threatening_piece?(color)
    killer_piece = checking_piece(color)
    return unless killer_piece

    killer_position = killer_piece.position_to_array_index
    opponent_color = color == 'white' ? 'black' : 'white'
    friendly_pieces = @chessboard.board.flatten.filter { |piece| piece.color == opponent_color }
    friendly_pieces.any? { |piece| piece.valid_moves(@chessboard.board).include?(killer_position) }
    # killer_moves.each do |killer_move|
    #   friendly_pieces.any? { |piece| piece.valid_moves(@chessboard.board).include?(killer_move) }
    # end
  end

  def interruptible_pieces(color)
    pieces = [Rook, Queen, Bishop]
    @chessboard.board.flatten.filter { |piece| piece.color == color && pieces.include?(piece.class) }
  end

  def threat_path(color)
    # find the threatening piece
    # find opponent king position
    # find the direction or path to the king by filtering out path that leads to king
    # know king moves
    # know which of kings moves are included in killer's moves
    # use it to find the threat path
    # check if any friendly piece can move to the space
    # opponent_color = color == 'white' ? 'black' : 'white'
    killer = checking_piece(color)
    p killer
    return unless killer

    killer_movements_arr = [killer.left(killer, color, @chessboard.board),
                            killer.right(killer, color, @chessboard.board),
                            killer.upward(killer, color, @chessboard.board),
                            killer.downward(killer, color, @chessboard.board),
                            killer.top_left(killer, color, @chessboard.board),
                            killer.top_right(killer, color, @chessboard.board),
                            killer.bottom_left(killer, color, @chessboard.board),
                            killer.bottom_right(killer, color, @chessboard.board)]

    # killer_movements = @chessboard.board[killer[0]][killer[1]].valid_moves(@chessboard.board)

    color = color == 'white' ? 'black' : 'white'
    attacked_king = @chessboard.find_king(color)
    killer_movements_arr.each { |path| return path if path.include?(attacked_king) }
    []
    # return unless attacked_king

    # king_movements = @chessboard.board[attacked_king[0]][attacked_king[1]].valid_moves(@chessboard.board)
    # king_movements.each { |movement| return movement if killer_movements.include?(movement) }
  end

  def friend_intercede?(color)
    killer_path = threat_path(color)
    color = color == 'white' ? 'black' : 'white'
    all_friendly_pieces = @chessboard.board.flatten.filter { |piece| piece.color == color }
    all_friendly_moves = all_friendly_pieces.map { |piece| piece.valid_moves(@chessboard.board) }
    all_friendly_moves.any? { |move| killer_path.include?(move) }
  end

  def turn_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def reset
    @chessboard = ChessBoard.new
    @current_player = @player1
  end

  def replay?
    puts 'Do you want to play again? [y/n]'
    response = gets.chomp.downcase
    play if response == 'y'
  end

  def display_board(selected_piece = nil)
    # chessboard = @chessboard.board
    colors = %i[light_yellow light_magenta]
    board = @chessboard.board
    move_to = []
    move_to = board[selected_piece[0]][selected_piece[1]].valid_moves(board) if selected_piece
    color_area(board, selected_piece, move_to, colors)
  end

  def color_area(board, selected_piece, move_to, colors)
    8.downto(1) do |i|
      print "#{i} "
      board[i - 1].each_with_index do |field, index|
        if move_to.include?([i - 1, index])
          print " #{field}  ".colorize(background: :red)
        elsif selected_piece == [i - 1, index]
          print " #{field}  ".colorize(background: :green)
        else
          print " #{field}  ".colorize(background: colors[0])
        end
        colors.rotate!
      end
      colors.rotate!
      print " #{i}\n"
    end
  end
end

a = Game.new
b = a.chessboard.board

p a.checking_piece('white')
