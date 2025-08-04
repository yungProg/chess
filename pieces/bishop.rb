# frozen_string_literal: true

require_relative 'piece'
require_relative '../helpers/movements'

# Describes Bishop functionalities
class Bishop < Piece
  include Movements
  def valid_moves(board)
    piece_array_id = position_to_array_index
    top_right_diagonal_moves(piece_array_id, @color, board) +
      top_left_diagonal_moves(piece_array_id, @color, board) +
      bottom_left_diagonal_moves(piece_array_id, @color, board) +
      bottom_right_diagonal_moves(piece_array_id, @color, board)
  end
end
