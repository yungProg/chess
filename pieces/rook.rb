# frozen_string_literal: true

require_relative 'piece'
require_relative '../helpers/movements'

# Describes functionalities of a Rook
class Rook < Piece
  include Movements
  def valid_moves(board)
    piece_array_id = position_to_array_index
    left_moves(piece_array_id, @color, board) +
      right_moves(piece_array_id, @color, board) +
      upward_moves(piece_array_id, @color, board) +
      downward_moves(piece_array_id, @color, board)
  end
end
