# frozen_string_literal: true

# defines pieces current position in the array
module PieceCoordinates
  def x_coordinate(position = @position)
    letter_to_num = { 'a': 0, 'b': 1, 'c': 2, 'd': 3, 'e': 4, 'f': 5, 'g': 6, 'h': 7 }
    letter_to_num[position[0].to_sym]
  end

  def y_coordinate(position = @position)
    (position[1].to_i - 8).abs
  end

  def coordinates(position = @position)
    [y_coordinate(position), x_coordinate(position)]
  end

  def coordinates_to_pos(movements)
    num_to_letters = { '0': 'a', '1': 'b', '2': 'c', '3': 'd', '4': 'e', '5': 'f', '6': 'g', '7': 'h' }
    moves = []
    movements.each { |m, n| moves.push("#{num_to_letters[m.to_s.to_sym]}#{(n - 8).abs}") }
    moves
  end
end
