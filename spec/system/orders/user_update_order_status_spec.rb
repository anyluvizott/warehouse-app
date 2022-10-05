require 'rails_helper'

describe 'Usuário informa novo status de pedido' do
  it 'e pedido foi entregue' do
    # Arrange
    any = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

    ware = Warehouse.create!(name: 'Aeroporto Internacional Afonso Pena', code: 'CWB', city: 'São José dos Pinhais', area: 150_000,
                             address: 'Av. Rocha Pombo, 1000', cep: '83010-900',
                             description: 'Galpão destinado para cargas internacionais')

    sup = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                           full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

    order = Order.create!(user: any, warehouse: ware, supplier: sup, estimated_delivery_date: 1.day.from_now,
                          status: :pending)

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
  end

  it 'e pedido foi cancelado' do
    # Arrange
    any = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

    ware = Warehouse.create!(name: 'Aeroporto Internacional Afonso Pena', code: 'CWB', city: 'São José dos Pinhais', area: 150_000,
                             address: 'Av. Rocha Pombo, 1000', cep: '83010-900',
                             description: 'Galpão destinado para cargas internacionais')

    sup = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                           full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

    order = Order.create!(user: any, warehouse: ware, supplier: sup, estimated_delivery_date: 1.day.from_now,
                          status: :pending)

    # Act
    login_as(any)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como CANCELADO'

    # Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Situação do Pedido: Cancelado'
  end
end
