# frozen_string_literal: true
require_relative 'piece_spec'
require_relative '../pieces/rook'

describe Rook do
  subject(:rook) { described_class.new('white') }
  context "when Rook is a child class of Piece" do
    include_examples 'color'
  end
end
