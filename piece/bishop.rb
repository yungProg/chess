# frozen_string_literal: true

require_relative 'piece'

# a bishop
class Bishop < Piece
  def valid_moves
    pos_x = x_coordinate
    pos_y = y_coordinate
    moves = []
    7.times do |i|
      moves.push([pos_x + i, pos_y + i], [pos_x - i, pos_y + i], [pos_x + i, pos_y - i], [pos_x - i, pos_y - i])
    end
    moves.filter! { |x, y| x.between?(0, 7) && y.between?(0, 7) }
  end

  def to_s
    if @color == 'white'
      "\u2657"
    else
      "\u265d"
    end
  end
end
