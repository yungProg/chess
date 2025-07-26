# frozen_string_literal: true

# Super class for all piece
class Piece
  attr_reader :color

  def initialize(color)
    @color = color
  end
end
