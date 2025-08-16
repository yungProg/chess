# frozen_string_literal: true

# Create players
class Player
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def to_hash
    { 'color' => @color }
  end

  def self.from_hash(data)
    new(data['color'])
  end

  def take_input
    loop do
      player_input = gets.chomp
      return verify_range(player_input) if verify_range(player_input)

      puts 'Invalid range! Please choose a range between a-h with 1-8'
    end
  end

  def verify_range(range)
    return nil unless range.match?(/^[a-h][1-8]$/)

    letter_to_num = { 'a': 0, 'b': 1, 'c': 2, 'd': 3, 'e': 4, 'f': 5, 'g': 6, 'h': 7 }
    split_range = [[range[1], range[0]]]
    coordinates = []
    split_range.each { |x, y| coordinates.concat([(x.to_i - 8).abs, letter_to_num[y.to_sym]]) }
    coordinates
  end
end
