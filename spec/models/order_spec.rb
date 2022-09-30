require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#description' do
    it 'exibe o nome e o email' do
      u = User.new(name: 'Rafael Hitoshi', email: 'rafahito@email.com')
      result = u.description
      expect(result).to eq 'Rafael Hitoshi - rafahito@email.com'
    end
  end
end
