# frozen_string_literal: true

# Piece master class
class Piece
  def initialize(color, position)
    @color = color
    @position = position
  end

  def valid_moves
    nil
  end

  def x_coordinate
    letter_to_num = { 'a': 0, 'b': 1, 'c': 2, 'd': 3, 'e': 4, 'f': 5, 'g': 6, 'h': 7 }
    letter_to_num[@position[0].to_sym]
  end

  def y_coordinate
    @position[1].to_i
  end

  def move_to(position, board)
    @position = position
    pos_x = x_coordinate
    pos_y = y_coordinate
    board[pos_x][pos_y] = self
  end
end
