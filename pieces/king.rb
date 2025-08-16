# frozen_string_literal: true

require_relative 'piece'

# Describes functionalities of a King
class King < Piece
  def valid_moves(board) # rubocop:disable Metrics/AbcSize
    y = position_to_array_index[0]
    x = position_to_array_index[1]
    pattern = [[0, 1], [0, -1], [1, 0], [-1, 0], [-1, 1], [1, -1], [-1, -1], [1, 1]]
    moves = []
    pattern.each do |i, j|
      next unless (y + i).between?(0, 7) && (x + j).between?(0, 7)

      moves << [y + i, x + j] if board[y + i][x + j].color.nil? || board[y + i][x + j].color != color
    end
    moves
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

  def to_s
    @color == 'white' ? '♔' : '♚'
  end
end
