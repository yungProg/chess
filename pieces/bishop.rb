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

  # def to_hash
  #   {
  #     'color' => @color,
  #     'position' => @position,
  #     'first_move' => @first_move
  #   }
  # end

  # def self.from_hash(data)
  #   piece = new(data['color'], data['position'])
  #   piece.instance_variable_set(:@first_move, data['first_move'])
  #   piece
  # end

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

  def top_left(piece_array_id, color, board = [])
    top_left_diagonal_moves(piece_array_id, color, board)
  end

  def top_right(piece_array_id, color, board = [])
    top_right_diagonal_moves(piece_array_id, color, board)
  end

  def bottom_left(piece_array_id, color, board = [])
    bottom_left_diagonal_moves(piece_array_id, color, board)
  end

  def bottom_right(piece_array_id, color, board = [])
    bottom_right_diagonal_moves(piece_array_id, color, board)
  end

  def to_s
    @color == 'white' ? '♗' : '♝'
  end
end
