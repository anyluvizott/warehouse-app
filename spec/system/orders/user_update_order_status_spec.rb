require 'rails_helper'

describe 'Usuário informa novo status de pedido' do
  it 'e pedido foi entregue' do
    # Arrange
    any = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

    warehouse = Warehouse.create!(name: 'Aeroporto Internacional Afonso Pena', code: 'CWB', city: 'São José dos Pinhais', area: 150_000,
                                  address: 'Av. Rocha Pombo, 1000', cep: '83010-900',
                                  description: 'Galpão destinado para cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

    product = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'SAMSU-TV40-60-5502-P',
                                   supplier:)

    order = Order.create!(user: any, warehouse:, supplier:, estimated_delivery_date: 1.day.from_now,
                          status: :pending)

    OrderItem.create!(order:, product_model: product, quantity: 5)

    # Act
    login_as(any)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como ENTREGUE'

    # Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Situação do Pedido: Entregue'
    expect(page).not_to have_button 'Marcar como CANCELADO'
    expect(page).not_to have_button 'Marcar como ENTREGUE'
    expect(StockProduct.count).to eq 5
    estoque = StockProduct.where(product_model: product, warehouse:).count
    expect(estoque).to eq 5
  end

  it 'e pedido foi cancelado' do
    # Arrange
    any = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

    warehouse = Warehouse.create!(name: 'Aeroporto Internacional Afonso Pena', code: 'CWB', city: 'São José dos Pinhais', area: 150_000,
                                  address: 'Av. Rocha Pombo, 1000', cep: '83010-900',
                                  description: 'Galpão destinado para cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

    product = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'SAMSU-TV40-60-5502-P',
                                   supplier:)

    order = Order.create!(user: any, warehouse:, supplier:, estimated_delivery_date: 1.day.from_now,
                          status: :pending)

    OrderItem.create!(order:, product_model: product, quantity: 5)

    # Act
    login_as(any)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como CANCELADO'

    # Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Situação do Pedido: Cancelado'
    expect(StockProduct.count).to eq 0
  end
end
