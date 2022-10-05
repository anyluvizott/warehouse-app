require 'rails_helper'

describe 'Usuário vê seus prórpios pedidos' do
  it 'e deve estar autenticado' do
    visit root_path
    click_on 'Meus Pedidos'

    expect(current_path).to eq new_user_session_path
  end

  it 'e não vê outros pedidos' do
    # Arrange
    any = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')
    joao = User.create!(email: 'joao@email.com', password: 'password', name: 'João')

    ware = Warehouse.create!(name: 'Aeroporto Internacional Afonso Pena', code: 'CWB', city: 'São José dos Pinhais', area: 150_000,
                             address: 'Av. Rocha Pombo, 1000', cep: '83010-900',
                             description: 'Galpão destinado para cargas internacionais')

    sup = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                           full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

    first_order = Order.create!(user: joao, warehouse: ware, supplier: sup, estimated_delivery_date: 1.day.from_now,
                                status: 'pending')

    second_order = Order.create!(user: any, warehouse: ware, supplier: sup, estimated_delivery_date: 1.day.from_now,
                                 status: 'delivered')

    third_order = Order.create!(user: joao, warehouse: ware, supplier: sup, estimated_delivery_date: 1.week.from_now,
                                status: 'canceled')

    # Act:
    login_as(joao)
    visit root_path
    click_on 'Meus Pedidos'

    # Assert:
    expect(page).to have_content first_order.code
    expect(page).to have_content 'Pendente'
    expect(page).not_to have_content second_order.code
    expect(page).not_to have_content 'Entregue'
    expect(page).to have_content third_order.code
    expect(page).to have_content 'Cancelado'
  end

  it 'e visita um pedido' do
    any = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')
    ware = Warehouse.create!(name: 'Aeroporto Internacional Afonso Pena', code: 'CWB', city: 'São José dos Pinhais', area: 150_000,
                             address: 'Av. Rocha Pombo, 1000', cep: '83010-900',
                             description: 'Galpão destinado para cargas internacionais')

    sup = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                           full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

    first_order = Order.create!(user: any, warehouse: ware, supplier: sup, estimated_delivery_date: 1.day.from_now)

    login_as(any)
    visit root_path
    click_on 'Meus Pedidos'
    click_on first_order.code

    expect(page).to have_content 'Detalhes do Pedido'
    expect(page).to have_content first_order.code
    expect(page).to have_content 'Galpão Destino: CWB - Aeroporto Internacional Afonso Pena'
    expect(page).to have_content 'Fornecedor: ACME LTDA'
    formated_date = I18n.localize(1.day.from_now.to_date)
    expect(page).to have_content "Data Prevista de Entrega: #{formated_date}"
  end

  it 'e não visita pedidos de outros usuários' do
    any = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')
    andre = User.create!(email: 'andre@email.com', password: 'password', name: 'André')
    ware = Warehouse.create!(name: 'Aeroporto Internacional Afonso Pena', code: 'CWB', city: 'São José dos Pinhais', area: 150_000,
                             address: 'Av. Rocha Pombo, 1000', cep: '83010-900',
                             description: 'Galpão destinado para cargas internacionais')

    sup = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                           full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

    first_order = Order.create!(user: any, warehouse: ware, supplier: sup, estimated_delivery_date: 1.day.from_now)

    login_as(andre)
    visit order_path(first_order.id)

    expect(current_path).not_to eq order_path(first_order.id)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não possui acesso a este pedido.'
  end

  it 'e vê itens do pedido' do
    # Arrange
    sup = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                           full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')
    any = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

    ware = Warehouse.create!(name: 'Aeroporto Internacional Afonso Pena', code: 'CWB', city: 'São José dos Pinhais', area: 150_000,
                             address: 'Av. Rocha Pombo, 1000', cep: '83010-900',
                             description: 'Galpão destinado para cargas internacionais')

    product_a = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'SAMSU-TV40-60-5502-P',
                                     supplier: sup)

    product_b = ProductModel.create!(name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15, depth: 20, sku: 'SAMSU-SOBA-80-6345-V',
                                     supplier: sup)

    product_c = ProductModel.create!(name: 'Produto C', weight: 3000, width: 80, height: 15, depth: 20, sku: 'SAMSU-PROD-80-6345-V',
                                     supplier: sup)

    order = Order.create!(user: any, warehouse: ware, supplier: sup,
                          estimated_delivery_date: 1.day.from_now, status: 'pending')

    OrderItem.create!(product_model: product_a, order:, quantity: 19)

    OrderItem.create!(product_model: product_b, order:, quantity: 12)
    # Act
    login_as(any)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code

    # Assert
    expect(page).to have_content 'Itens do Pedido' 
    expect(page).to have_content '19 x TV 32' 
    expect(page).to have_content '12 x SoundBar 7.1 Surround' 



  end
end
