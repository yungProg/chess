# frozen_string_literal: true

require_relative 'piece'

# Describes functionalities of knight
class Knight < Piece
  def valid_moves(board) # rubocop:disable Metrics/AbcSize
    y = position_to_array_index[0]
    x = position_to_array_index[1]
    pattern = [[1, 2], [2, 1], [-1, 2], [2, -1], [1, -2], [-2, 1], [-1, -2], [-2, -1]]
    moves = []
    pattern.each do |i, j|
      next unless (y + i).between?(0, 7) && (x + j).between?(0, 7)

      moves << [y + i, x + j] if board[y + i][x + j].nil? || board[y + i][x + j].color != color
    end
    moves
  end
end
