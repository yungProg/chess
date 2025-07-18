# frozen_string_literal: true

require_relative 'piece'

# a rook
class Rook < Piece
  def valid_moves
    pos_x = y_coordinate
    pos_y = x_coordinate
    moves = []
    1.upto(7) { |i| moves.push([pos_x + i, pos_y], [pos_x, pos_y + i], [pos_x - i, pos_y], [pos_x, pos_y - i]) }
    moves.filter { |x, y| x.between?(0, 7) && y.between?(0, 7) }
  end

  def to_s
    if @color == 'white'
      "\u2656"
    else
      "\u265c"
    end
  end
end
