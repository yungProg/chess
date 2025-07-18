# frozen_string_literal: true

require_relative '../helper/piece_coordinates'

# Piece master class
class Piece
  attr_accessor :color, :position
  include PieceCoordinates
  def initialize(color, position)
    @color = color
    @position = position
  end

  def valid_moves
    nil
  end

  def move_to(position, board)
    @position = position
    pos_x = x_coordinate
    pos_y = y_coordinate
    board[pos_x][pos_y] = self
  end

  def to_s
    '.'
  end
end
