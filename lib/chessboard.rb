class ChessBoard
  attr_reader :board
  def initialize
    @board = Array.new(8) {Array.new(8)}
    arrange_pieces
  end

  def arrange_pieces
  end
end
