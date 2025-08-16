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

  def left(piece_array_id, color, board = [])
    left_moves(piece_array_id, color, board)
  end

  def right(piece_array_id, color, board = [])
    right_moves(piece_array_id, color, board)
  end

  def upward(piece_array_id, color, board = [])
    upward_moves(piece_array_id, color, board)
  end

  def downward(piece_array_id, color, board = [])
    downward_moves(piece_array_id, color, board)
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
    @color == 'white' ? '♖' : '♜'
  end
end
