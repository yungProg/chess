# frozen_string_literal: true

RSpec.shared_examples 'color' do
  context 'when method is from base class' do
    it 'responds to color' do
      expect(subject).to respond_to(:color)
    end
    it 'knows its position' do
      expect(subject).to respond_to(:position)
    end
  end
end
