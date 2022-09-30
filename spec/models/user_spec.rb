require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    it 'false when name is empty' do
      user = User.new(email: 'any@email.com', password: 'password', name: '')

      result = user.valid?

      expect(result).to eq false
    end
  end

  describe '#description' do
    it 'exibe o nome e o email' do
      u = User.new(name: 'Rafael Hitoshi', email: 'rafahito@email.com')
      result = u.description
      expect(result).to eq 'Rafael Hitoshi - rafahito@email.com'
    end
  end
end
