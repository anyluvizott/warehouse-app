require 'rails_helper'

describe 'Usuário adiciona itens ao pedido' do
  it 'com sucesso' do
    # Arrange
    any = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

    warehouse = Warehouse.create!(name: 'Aeroporto Internacional Afonso Pena', code: 'CWB', city: 'São José dos Pinhais', area: 150_000,
                                  address: 'Av. Rocha Pombo, 1000', cep: '83010-900',
                                  description: 'Galpão destinado para cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

    order = Order.create!(user: any, warehouse:, supplier:, estimated_delivery_date: 1.day.from_now)

    product_a = ProductModel.create!(name: 'Produto A', weight: 8000, width: 70, height: 45, depth: 10, sku: 'SAMSU-TV40-60-5502-P',
                                     supplier:)

    product_b = ProductModel.create!(name: 'Produto B', weight: 3000, width: 80, height: 15, depth: 20, sku: 'SAMSU-SOBA-80-6345-V',
                                     supplier:)

    # Act
    login_as(any)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'

    select 'Produto A', from: 'Produto'
    fill_in 'Quantidade',	with: '8'
    click_on 'Gravar'

    # Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Item adicionado com sucesso'
    expect(page).to have_content '8 x Produto A'
  end

  it 'e não vê produtos de outro fornecedor' do
    any = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

    warehouse = Warehouse.create!(name: 'Aeroporto Internacional Afonso Pena', code: 'CWB', city: 'São José dos Pinhais', area: 150_000,
                                  address: 'Av. Rocha Pombo, 1000', cep: '83010-900',
                                  description: 'Galpão destinado para cargas internacionais')

    supplier_a = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                                  full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

    supplier_b = Supplier.create!(corporate_name: 'YELLOW Distribuidora', brand_name: 'Yellow', registration_number: '34108887000158',
                                  full_address: 'Rua Maestro Francisco Antonello, 382', city: 'Curitiba', state: 'PR', email: 'vendas@yellow.com', phone_number: '41996681994')

    order = Order.create!(user: any, warehouse:, supplier: supplier_a,
                          estimated_delivery_date: 1.day.from_now)

    product_a = ProductModel.create!(name: 'Produto A', weight: 8000, width: 70, height: 45, depth: 10, sku: 'SAMSU-TV40-60-5502-P',
                                     supplier: supplier_a)

    product_b = ProductModel.create!(name: 'Produto B', weight: 3000, width: 80, height: 15, depth: 20, sku: 'SAMSU-SOBA-80-6345-V',
                                     supplier: supplier_b)

    login_as(any)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'

    expect(page).to have_content 'Produto A'
    expect(page).not_to have_content 'Produto B'
  end
end
