# frozen_string_literal: true

require_relative 'chessboard'
require_relative 'player'
require_relative '../pieces/piece'
require 'colorize'
require 'yaml'

# Defines game flow
class Game # rubocop:disable Metrics/ClassLength
  attr_reader :chessboard, :player1, :player2, :current_player

  def initialize
    @player1 = Player.new('white')
    @player2 = Player.new('black')
    @chessboard = ChessBoard.new
    @current_player = @player1
  end

  def save_game
    Dir.mkdir('saves') unless Dir.exist?('saves')
    game_state = {
      'player1' => @player1.to_hash, 'player2' => @player2.to_hash,
      'chessboard' => @chessboard.to_hash, 'current_player' => @current_player.to_hash
    }

    File.write('saves/save0.yml', game_state.to_yaml)
    puts 'Game successfully saved to saves/save0.yml'
  rescue StandardError => e
    puts "Error saving game: #{e.message}"
  end

  def self.load_game
    unless File.exist?('saves/save0.yml')
      puts "File saves/save0.yml doesn't exist"
      return
    end

    saved_data = YAML.load_file('saves/save0.yml')
    player1 = Player.from_hash(saved_data['player1'])
    player2 = Player.from_hash(saved_data['player2'])
    chessboard = ChessBoard.from_hash(saved_data['chessboard'])
    current_player = Player.from_hash(saved_data['current_player'])

    game = new
    game.instance_variable_set(:@player1, player1)
    game.instance_variable_set(:@player2, player2)
    game.instance_variable_set(:@chessboard, chessboard)
    game.instance_variable_set(:@current_player, current_player)
    puts 'Game successfully loaded from saves/save0.yml'
    game
  rescue Psych::SyntaxError
    puts 'Invalid file format in saves/save0.yml'
  rescue StandardError => e
    puts "Error loading game: #{e.message}"
  end

  def play
    loop do
      move_piece
      display_board
      break if checkmate?(@current_player.color)

      turn_player
      save_game
    end
    puts "#{@current_player.color} won"
    replay?
  end

  def initial_piece_move
    move_from = nil
    move_to = nil

    loop do
      display_board
      move_from = verify_selected_piece
      display_board(move_from)
      board = @chessboard.board
      possible_destinations = @chessboard.board[move_from[0]][move_from[1]].valid_moves(board)
      move_to = verify_destination(possible_destinations)
      return [move_from, move_to] if move_from && move_to
    end
  end

  def move_piece # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    loop do
      move_from_to = initial_piece_move
      move_from = move_from_to[0]
      move_to = move_from_to[1]
      piece_copy = @chessboard.board[move_from[0]][move_from[1]]
      destination_copy = @chessboard.board[move_to[0]][move_to[1]]
      @chessboard.board[move_to[0]][move_to[1]] = @chessboard.board[move_from[0]][move_from[1]]
      @chessboard.board[move_from[0]][move_from[1]] = Piece.new(nil, '')
      @chessboard.board[move_to[0]][move_to[1]].update_position(move_to)
      unless king_checked?(@current_player.color)
        # @chessboard.board[move_to[0]][move_to[1]].update_position(move_to)
        @chessboard.board[move_to[0]][move_to[1]].moved
        return
      end
      puts "#{@current_player.color.upcase}: Move exposes your king! Try another move"
      @chessboard.board[move_from[0]][move_from[1]] = piece_copy
      @chessboard.board[move_from[0]][move_from[1]].update_position(move_from)
      @chessboard.board[move_to[0]][move_to[1]] = destination_copy
      # display_board
    end
    # temporarily move the piece
    # check if it puts the king under check?
    # confirm move if it doesn't but revert if it does
  end

  def verify_selected_piece
    puts "#{@current_player.color.upcase} select piece"
    loop do
      player_choice = @current_player.take_input
      return player_choice if @chessboard.board[player_choice[0]][player_choice[1]].color == @current_player.color

      puts 'Please select a piece belonging to you!'
    end
  end

  def verify_destination(legal_destinations)
    puts "#{@current_player.color.upcase} select destination"
    player_choice = @current_player.take_input
    # return player_choice if legal_destinations.include?(@chessboard.board[player_choice[0]][player_choice[1]])
    return player_choice if legal_destinations.include?(player_choice)

    puts 'Invalid destination'
    display_board
  end

  def king_checked?(color)
    king_position = @chessboard.find_king(color)
    opponent_color = color == 'white' ? 'black' : 'white'
    opponent_pieces = @chessboard.board.flatten.filter { |piece| piece.color == opponent_color }
    opponent_pieces.any? { |piece| piece.valid_moves(@chessboard.board).include?(king_position) }
  end

  def checkmate?(color)
    opponent_color = color == 'white' ? 'black' : 'white'
    return false unless king_checked?(opponent_color)

    return false if friend_intercede?(color) || capture_threatening_piece?(color) || king_escape?

    # return true unless false && capture_threatening_piece?(color) && false

    true
  end

  def checking_piece(color)
    opponent_color = color == 'white' ? 'black' : 'white'
    board = @chessboard.board
    king_position = @chessboard.find_king(opponent_color)
    player_pieces = board.flatten.filter { |piece| piece.color == color }
    player_pieces.find { |piece| piece.valid_moves(board).include?(king_position) }
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

    board = @chessboard.board
    killer_position = killer_piece.position_to_array_index
    opponent_color = color == 'white' ? 'black' : 'white'
    friendly_pieces = board.flatten.filter { |piece| piece.color == opponent_color }
    friendly_pieces.any? { |piece| piece.valid_moves(board).include?(killer_position) }
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
    return [] unless killer

    killer_pos = killer.position_to_array_index
    killer_movements_arr = [killer.left(killer_pos, color, @chessboard.board),
                            killer.right(killer_pos, color, @chessboard.board),
                            killer.upward(killer_pos, color, @chessboard.board),
                            killer.downward(killer_pos, color, @chessboard.board),
                            killer.top_left(killer_pos, color, @chessboard.board),
                            killer.top_right(killer_pos, color, @chessboard.board),
                            killer.bottom_left(killer_pos, color, @chessboard.board),
                            killer.bottom_right(killer_pos, color, @chessboard.board)]

    # killer_movements = @chessboard.board[killer[0]][killer[1]].valid_moves(@chessboard.board)

    opponent_color = color == 'white' ? 'black' : 'white'
    attacked_king = @chessboard.find_king(opponent_color)
    # killer_movements_arr.each { |path| return path if path.include?(attacked_king) }
    kill_path = killer_movements_arr.find { |path| path.include?(attacked_king) }
    kill_path || []
    # return unless attacked_king

    # king_movements = @chessboard.board[attacked_king[0]][attacked_king[1]].valid_moves(@chessboard.board)
    # king_movements.each { |movement| return movement if killer_movements.include?(movement) }
  end

  def friend_intercede?(color)
    killer_path = threat_path(color)
    return false if killer_path.empty?

    opponent_color = color == 'white' ? 'black' : 'white'
    board = @chessboard.board
    all_friendly_pieces = board.flatten.filter { |piece| piece.color == opponent_color }
    all_friendly_moves = all_friendly_pieces.map { |piece| piece.valid_moves(board) }
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
    return unless response == 'y'

    reset
    play
  end

  def display_board(selected_piece = nil)
    # chessboard = @chessboard.board
    colors = %i[light_yellow light_magenta]
    board = @chessboard.board
    move_to = []
    move_to = board[selected_piece[0]][selected_piece[1]].valid_moves(board) if selected_piece
    print "   a    b   c   d   e   f   g   h\n"
    color_area(board, selected_piece, move_to, colors)
    print "   a    b   c   d   e   f   g   h\n"
  end

  def color_area(board, selected_piece, move_to, colors) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    1.upto(8) do |i|
      print "#{(i - 9).abs} "
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
      print " #{(i - 9).abs}\n"
    end
  end
end
