require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'gera um número de série' do
    it 'ao criar um StockProduct' do
      user = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

      warehouse = Warehouse.create!(name: 'Aeroporto Internacional Afonso Pena', code: 'CWB',
                                    city: 'São José dos Pinhais', area: 150_000, address: 'Av. Rocha Pombo, 1000', cep: '83010-900', description: 'Galpão destinado para cargas internacionais')

      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                                  full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

      order = Order.create!(user:, warehouse:, supplier:, status: :delivered,
                            estimated_delivery_date: 1.week.from_now)

      product = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45,
                                     depth: 10, sku: 'SAMSU-TV40-60-5502-P', supplier:)

      stock_product = StockProduct.create!(order:, warehouse:, product_model: product)

      expect(stock_product.serial_number.length).to eq 20
    end

    it 'e não é modificado' do
      user = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

      warehouse = Warehouse.create!(name: 'Aeroporto Internacional Afonso Pena', code: 'CWB',
                                    city: 'São José dos Pinhais', area: 150_000, address: 'Av. Rocha Pombo, 1000', cep: '83010-900', description: 'Galpão destinado para cargas internacionais')

      other_warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU',
                                          city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')

      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                                  full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

      order = Order.create!(user:, warehouse:, supplier:, status: :delivered,
                            estimated_delivery_date: 1.week.from_now)

      product = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45,
                                     depth: 10, sku: 'SAMSU-TV40-60-5502-P', supplier:)

      stock_product = StockProduct.create!(order:, warehouse:, product_model: product)

      original_serial_number = stock_product.serial_number

      stock_product.update!(warehouse: other_warehouse)

      expect(stock_product.serial_number).to eq original_serial_number
    end
  end
end
