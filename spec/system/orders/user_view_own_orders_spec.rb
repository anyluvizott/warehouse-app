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

    first_order = Order.create!(user: joao, warehouse: ware, supplier: sup, estimated_delivery_date: 1.day.from_now)

    second_order = Order.create!(user: any, warehouse: ware, supplier: sup, estimated_delivery_date: 1.day.from_now)

    third_order = Order.create!(user: joao, warehouse: ware, supplier: sup, estimated_delivery_date: 1.week.from_now)

    # Act:
    login_as(joao)
    visit root_path
    click_on 'Meus Pedidos'

    # Assert:
    expect(page).to have_content first_order.code
    expect(page).not_to have_content second_order.code
    expect(page).to have_content third_order.code
  end
end
