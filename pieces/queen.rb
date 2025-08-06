# frozen_string_literal: true

require_relative 'piece'
require_relative '../helpers/movements'

# Describes functionalities of Queen
class Queen < Piece
  include Movements
  def valid_moves(board)
    piece_array_id = position_to_array_index
    top_right_diagonal_moves(piece_array_id, @color, board) +
      top_left_diagonal_moves(piece_array_id, @color, board) +
      bottom_left_diagonal_moves(piece_array_id, @color, board) +
      bottom_right_diagonal_moves(piece_array_id, @color, board) +
      left_moves(piece_array_id, @color, board) +
      right_moves(piece_array_id, @color, board) +
      upward_moves(piece_array_id, @color, board) +
      downward_moves(piece_array_id, @color, board)
  end

  def to_s
    @color == 'white' ? '♕' : '♛'
  end
end
