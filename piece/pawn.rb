# frozen_string_literal: true

require_relative 'piece'

# a pawn
class Pawn < Piece
  def valid_moves
    pos_x = y_coordinate
    pos_y = x_coordinate
    moves = if @color == 'black'
              [[pos_x + 1, pos_y + 0], [pos_x + 2, pos_y + 0]]
            else
              [[pos_x - 1, pos_y + 0], [pos_x - 2, pos_y + 0]]
            end
    moves.filter { |x, y| x.between?(0, 7) && y.between?(0, 7) }
  end

  def to_s
    if @color == 'white'
      "\u2659"
    else
      "\u265f"
    end
  end
end
