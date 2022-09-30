require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'deve ter um código' do
      # Arrange - criar um pedido (somente objeto) com todos os campos menos o código.
      user = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

      warehouse = Warehouse.create!(name: 'Aeroporto Internacional Afonso Pena', code: 'CWB',
                                    city: 'São José dos Pinhais', area: 150_000, address: 'Av. Rocha Pombo, 1000', cep: '83010-900', description: 'Galpão destinado para cargas internacionais')

      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                                  full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

      order = Order.new(user:user, warehouse:warehouse, supplier:supplier, estimated_delivery_date: '2022-10-01')
     
      result = order.valid?

      expect(result).to be true 

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

      order = Order.new(user:user, warehouse:warehouse, supplier:supplier, estimated_delivery_date: '2022-10-01')
      # Act
      order.save!
      result = order.code
      # Assert
      expect(result).not_to be_empty
      expect(result.length).to eq 8
    end

    it 'e o código é único' do
      user = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

      warehouse = Warehouse.create!(name: 'Aeroporto Internacional Afonso Pena', code: 'CWB',
                                    city: 'São José dos Pinhais', area: 150_000, address: 'Av. Rocha Pombo, 1000', cep: '83010-900', description: 'Galpão destinado para cargas internacionais')

      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                                  full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

      first_order = Order.create!(user:user, warehouse:warehouse, supplier:supplier,
                                 estimated_delivery_date: '2022-10-01')

      second_order = Order.new(user:user, warehouse:warehouse, supplier:supplier,
                               estimated_delivery_date: '2022-11-15')

      second_order.save!

      expect(second_order.code).not_to eq first_order.code
    end
  end
end
