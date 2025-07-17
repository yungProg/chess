# frozen_string_literal: true

# Chess board representation
class Board
  def initialize
    @board = Array.new(8) { Array.new(8, '.') }
  end

  def display
    print "    a   b   c   d   e   f   g   h\n"
    7.downto(0) do |i|
      print "#{i + 1} "
      @board[i].each { |i| print "  #{i} " }
      print " #{i + 1}\n"
    end
    print "    a   b   c   d   e   f   g   h\n"
  end
end
