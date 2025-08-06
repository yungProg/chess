# frozen_string_literal: true

# Describes movements of pieces
module Movements # rubocop:disable Metrics/ModuleLength
  def left_moves(piece_index, color, board = []) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    moves = []
    y = piece_index[0]
    x = piece_index[1]
    1.upto(7) do |i|
      break unless (x - i).between?(0, 7)

      if board[y][x - i].color.nil?
        moves << [y, x - i]
      elsif board[y][x - i].color != color
        moves << [y, x - i]
        break
      else
        break
      end
    end
    moves
  end

  def right_moves(piece_index, color, board = []) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    moves = []
    y = piece_index[0]
    x = piece_index[1]
    1.upto(7) do |i|
      break unless (x + i).between?(0, 7)

      if board[y][x + i].color.nil?
        moves << board[y, x + i]
      elsif board[y][x + i].color != color
        moves << [y, x + i]
        break
      else
        break
      end
    end
    moves
  end

  def upward_moves(piece_index, color, board = []) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    moves = []
    y = piece_index[0]
    x = piece_index[1]
    1.upto(7) do |i|
      break unless (y - i).between?(0, 7)

      if board[y - i][x].color.nil?
        moves << [y - i, x]
      elsif board[y - i][x].color != color
        moves << [y - i, x]
        break
      else
        break
      end
    end
    moves
  end

  def downward_moves(piece_index, color, board = []) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    moves = []
    y = piece_index[0]
    x = piece_index[1]
    1.upto(7) do |i|
      break unless (y + i).between?(0, 7)

      if board[y + i][x].color.nil?
        moves << [y + i, x]
      elsif board[y + i][x].color != color
        moves << [y + i, x]
        break
      else
        break
      end
    end
    moves
  end

  def top_right_diagonal_moves(piece_index, color, board = []) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    moves = []
    y = piece_index[0]
    x = piece_index[1]
    1.upto(7) do |i|
      break unless (y - i).between?(0, 7) && (x + i).between?(0, 7)

      if board[y - i][x + i].color.nil?
        moves << [y - i, x + i]
      elsif board[y - i][x + i].color != color
        moves << [y - i, x + i]
        break
      else
        break
      end
    end
    moves
  end

  def top_left_diagonal_moves(piece_index, color, board = []) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    moves = []
    y = piece_index[0]
    x = piece_index[1]
    1.upto(7) do |i|
      break unless (y - i).between?(0, 7) && (x - i).between?(0, 7)

      if board[y - i][x - i].color.nil?
        moves << [y - i, x - i]
      elsif board[y - i][x - i].color != color
        moves << [y - i, x - i]
        break
      else
        break
      end
    end
    moves
  end

  def bottom_left_diagonal_moves(piece_index, color, board = []) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    moves = []
    y = piece_index[0]
    x = piece_index[1]
    1.upto(7) do |i|
      break unless (y + i).between?(0, 7) && (x - i).between?(0, 7)

      if board[y + i][x - i].color.nil?
        moves << [y + i, x - i]
      elsif board[y + i][x - i].color != color
        moves << [y + i, x - i]
        break
      else
        break
      end
    end
    moves
  end

  def bottom_right_diagonal_moves(piece_index, color, board = []) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    moves = []
    y = piece_index[0]
    x = piece_index[1]
    1.upto(7) do |i|
      break unless (y + i).between?(0, 7) && (x + i).between?(0, 7)

      if board[y + i][x + i].color.nil?
        moves << [y + i, x + i]
      elsif board[y + i][x + i].color != color
        moves << [y + i, x + i]
        break
      else
        break
      end
    end
    moves
  end
end
