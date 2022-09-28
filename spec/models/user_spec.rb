require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    it 'false when name is empty' do
      user = User.new(email: 'any@email.com', password: 'password', name: '')

      result = user.valid?

      expect(result).to eq false
    end
  end
end
