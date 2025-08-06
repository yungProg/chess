# frozen_string_literal: true

# Super class for all piece
class Piece
  attr_reader :color, :position, :first_move

  def initialize(color, position)
    @color = color
    @position = position
    @first_move = true
  end

  def row_index
    letter_to_num = { 'a': 0, 'b': 1, 'c': 2, 'd': 3, 'e': 4, 'f': 5, 'g': 6, 'h': 7 }
    letter_to_num[@position[0].to_sym]
  end

  def column_index
    (@position[1].to_i - 8).abs
  end

  def position_to_array_index
    [column_index, row_index]
  end

  def has_moved
    @first_move = false
  end

  def to_s
    "\u00b7"
  end
end
