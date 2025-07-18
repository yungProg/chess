# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

# represents game flow
class Game
  def initialize(player1, player2)
    @player1 = Player.new(player1, 'white')
    @player2 = Player.new(player2, 'black')
    @chessboard = Board.new
    @current_player = @player1
  end

  def select_piece
    # can select pieces corresponding to his color
  end

  def verify_selected_piece
  end

  def turn_player
    @current_player = if @current_player == @player1
                        @player2
                      else
                        @player1
                      end
  end
end
