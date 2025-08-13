# frozen_string_literal: true

require_relative 'piece'

# Describes functionalities of pawn
class Pawn < Piece
  def black_moves
    y = position_to_array_index[0]
    x = position_to_array_index[1]
    moves = []
    moves << [y + 1, x] if (y + 1) < 8
    moves << [y + 2, x] if @first_move
    moves
  end

  def white_moves
    y = position_to_array_index[0]
    x = position_to_array_index[1]
    moves = []
    moves << [y - 1, x] if (y - 1) >= 0
    moves << [y - 2, x] if @first_move
    moves
  end

  def valid_moves(board)
    color_moves = { 'black': black_moves, 'white': white_moves }
    color_capture = { 'black': black_capture(board), 'white': white_capture(board) }
    moves = []
    move = color_moves[@color.to_sym]
    move.each { |y, x| moves << [y, x] if board[y][x].color.nil? }
    moves + color_capture[@color.to_sym]
  end

  def white_capture(board)
    xy = position_to_array_index
    area_for_attack = []
    area_for_attack << board[xy[0] - 1][xy[1] - 1] if (xy[0] - 1).between?(0, 7) && (xy[1] - 1).between?(0, 7)
    area_for_attack << board[xy[0] - 1][xy[1] + 1] if (xy[0] - 1).between?(0, 7) && (xy[1] + 1).between?(0, 7)
    # area_for_attack = [board[xy[0] - 1][xy[1] - 1], board[xy[0] - 1][xy[1] + 1]]
    return [] if area_for_attack.empty?

    # area_for_attack.filter { |piece| piece.color.nil? == false && piece.color != 'white' }
    area_for_attack.filter! { |piece| piece.color == 'black' }
    area_for_attack.map(&:position_to_array_index)
  end

  def black_capture(board)
    xy = position_to_array_index
    area_for_attack = []
    area_for_attack << board[xy[0] + 1][xy[1] - 1] if (xy[0] + 1).between?(0, 7) && (xy[1] - 1).between?(0, 7)
    area_for_attack << board[xy[0] + 1][xy[1] + 1] if (xy[0] + 1).between?(0, 7) && (xy[1] + 1).between?(0, 7)
    # area_for_attack = [board[xy[0] + 1][xy[1] - 1], board[xy[0] + 1][xy[1] + 1]]
    return [] if area_for_attack.empty?

    # area_for_attack.filter { |piece| piece.color.nil? == false && piece.color != 'black' }
    area_for_attack.filter! { |piece| piece.color == 'white' }
    area_for_attack.map(&:position_to_array_index)
  end

  def to_s
    @color == 'white' ? '♙' : '♟'
  end
end
