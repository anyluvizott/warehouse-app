require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'deve ter um código' do
      user = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

      warehouse = Warehouse.create!(name: 'Aeroporto Internacional Afonso Pena', code: 'CWB',
                                    city: 'São José dos Pinhais', area: 150_000, address: 'Av. Rocha Pombo, 1000', cep: '83010-900', description: 'Galpão destinado para cargas internacionais')

      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                                  full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

      order = Order.new(user:, warehouse:, supplier:, estimated_delivery_date: 1.day.from_now)

      result = order.valid?

      expect(result).to be true
    end

    it 'data estimada de entrega deve ser obrigatória' do
      order = Order.new(estimated_delivery_date: nil)

      order.valid?
      expect(order.errors.include?(:estimated_delivery_date)).to be true
    end

    it 'data estimada de entrega não deve ser passada' do
      # Arrange
      order = Order.new(estimated_delivery_date: 1.day.ago)

      # Act
      order.valid?

      # Assert
      expect(order.errors.include?(:estimated_delivery_date)).to be true
      expect(order.errors[:estimated_delivery_date]).to include(' deve ser futura')
    end

    it 'data estimada de entrega não deve ser hoje' do
      # Arrange
      order = Order.new(estimated_delivery_date: Date.today)

      # Act
      order.valid?

      # Assert
      expect(order.errors.include?(:estimated_delivery_date)).to be true
      expect(order.errors[:estimated_delivery_date]).to include(' deve ser futura')
    end

    it 'data estimada de entrega dever ser igual ou maior que amanhã' do
      # Arrange
      order = Order.new(estimated_delivery_date: 1.day.from_now)

      # Act
      order.valid?

      # Assert
      expect(order.errors.include?(:estimated_delivery_date)).to be false
    end
  end

  describe 'gera um código aleatório' do
    it 'ao criar um novo pedido' do
      # Arrange
      user = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

      warehouse = Warehouse.create!(name: 'Aeroporto Internacional Afonso Pena', code: 'CWB',
                                    city: 'São José dos Pinhais', area: 150_000, address: 'Av. Rocha Pombo, 1000', cep: '83010-900', description: 'Galpão destinado para cargas internacionais')

      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                                  full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

      order = Order.new(user:, warehouse:, supplier:, estimated_delivery_date: 1.day.from_now)
      # Act
      order.save!
      result = order.code
      # Assert
      expect(result).not_to be_empty
      expect(result.length).to eq 10
    end

    it 'e o código é único' do
      user = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

      warehouse = Warehouse.create!(name: 'Aeroporto Internacional Afonso Pena', code: 'CWB',
                                    city: 'São José dos Pinhais', area: 150_000, address: 'Av. Rocha Pombo, 1000', cep: '83010-900', description: 'Galpão destinado para cargas internacionais')

      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                                  full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

      first_order = Order.create!(user:, warehouse:, supplier:,
                                  estimated_delivery_date: 1.day.from_now)

      second_order = Order.new(user:, warehouse:, supplier:,
                               estimated_delivery_date: 1.day.from_now)

      second_order.save!

      expect(second_order.code).not_to eq first_order.code
    end

    it 'e não deve ser modificado' do
      user = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

      warehouse = Warehouse.create!(name: 'Aeroporto Internacional Afonso Pena', code: 'CWB',
                                    city: 'São José dos Pinhais', area: 150_000, address: 'Av. Rocha Pombo, 1000', cep: '83010-900', description: 'Galpão destinado para cargas internacionais')

      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                                  full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

      order = Order.create!(user:, warehouse:, supplier:,
                            estimated_delivery_date: 1.week.from_now)

      original_code = order.code

      # Act
      order.update!(estimated_delivery_date: 1.month.from_now)

      # Assert
      expect(order.code).to eq(original_code)
    end
  end
end
 