# frozen_string_literal: true

require_relative 'piece'

# a king
class King < Piece
  def valid_moves # rubocop:disable Metrics/AbcSize
    pos_x = x_coordinate
    pos_y = y_coordinate
    [
      [pos_x + 1, pos_y + 1], [pos_x + 1, pos_y + 0], [pos_x + 1, pos_y - 1], [pos_x - 0, pos_y - 1],
      [pos_x - 1, pos_y - 1], [pos_x - 1, pos_y + 0], [pos_x - 1, pos_y + 1], [pos_x + 0, pos_y + 1]
    ].filter { |x, y| x.between?(0, 7) && y.between?(0, 7) }
  end

  def to_s
    if @color == 'white'
      "\u2654"
    else
      "\u265a"
    end
  end
end
