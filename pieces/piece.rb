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

  def update_position(new_position)
    num_to_letter = { '0': 'a', '1': 'b', '2': 'c', '3': 'd', '4': 'e', '5': 'f', '6': 'g', '7': 'h' }
    @position = "#{num_to_letter[new_position[1].to_s.to_sym]}#{(new_position[0] - 8).abs}"
  end

  def moved
    @first_move = false
  end

  def valid_moves(*)
    []
  end

  def left(*)
    []
  end

  def right(*)
    []
  end

  def upward(*)
    []
  end

  def downward(*)
    []
  end

  def top_left(*)
    []
  end

  def top_right(*)
    []
  end

  def bottom_left(*)
    []
  end

  def bottom_right(*)
    []
  end

  def to_s
    "\u00b7"
  end
end
