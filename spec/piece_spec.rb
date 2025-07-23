RSpec.shared_examples 'color' do
  context 'when method is from base class' do
    it 'responds to color' do
      expect(subject).to respond_to(:color)
    end
  end
end