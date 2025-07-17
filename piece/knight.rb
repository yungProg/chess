# frozen_string_literal: true

require_relative 'piece'

# a knight
class Knight < Piece
  def valid_moves # rubocop:disable Metrics/AbcSize
    pos_x = x_coordinate
    pos_y = y_coordinate
    [
      [pos_x + 1, pos_y + 2], [pos_x + 1, pos_y - 2], [pos_x - 1, pos_y + 2], [pos_x - 1, pos_y - 2],
      [pos_x + 2, pos_y + 1], [pos_x + 2, pos_y - 1], [pos_x - 2, pos_y + 1], [pos_x - 2, pos_y - 1]
    ].filter! { |x, y| x.between?(0, 7) && y.between?(0, 7) }
  end

  def to_s
    if @color == 'white'
      "\u2658"
    else
      "\u265e"
    end
  end
end
