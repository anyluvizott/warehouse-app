require 'rails_helper'

describe 'Usuário edita pedido' do
  it 'e deve estar autenticado' do
    any = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

    ware = Warehouse.create!(name: 'Aeroporto Internacional Afonso Pena', code: 'CWB', city: 'São José dos Pinhais', area: 150_000,
                             address: 'Av. Rocha Pombo, 1000', cep: '83010-900',
                             description: 'Galpão destinado para cargas internacionais')

    sup = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                           full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

    order = Order.create!(user: any, warehouse: ware, supplier: sup, estimated_delivery_date: 1.day.from_now)

    visit edit_order_path(order.id)

    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    any = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

    ware = Warehouse.create!(name: 'Aeroporto Internacional Afonso Pena', code: 'CWB', city: 'São José dos Pinhais', area: 150_000,
                             address: 'Av. Rocha Pombo, 1000', cep: '83010-900',
                             description: 'Galpão destinado para cargas internacionais')

    sup = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                           full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')
    sup2 = Supplier.create!(corporate_name: 'YELLOW Distribuidora', brand_name: 'Yellow', registration_number: '34108887000158',
                            full_address: 'Rua Maestro Francisco Antonello, 382', city: 'Curitiba', state: 'PR', email: 'vendas@yellow.com', phone_number: '41996681994')

    order = Order.create!(user: any, warehouse: ware, supplier: sup, estimated_delivery_date: 1.day.from_now)

    login_as(any)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Editar'
    fill_in 'Data Prevista de Entrega',	with: 1.week.from_now
    select 'YELLOW Distribuidora', from: 'Fornecedor'
    click_on 'Gravar'

    expect(page).to have_content 'Pedido atualizado com sucesso.'
    expect(page).to have_content 'Fornecedor: YELLOW Distribuidora'
    expect(page).to have_content "Data Prevista de Entrega: #{I18n.localize(1.week.from_now.to_date)}"
  end

  it 'caso seja o responsável' do
    any = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')
    andre = User.create!(email: 'andre@email.com', password: 'password', name: 'André')

    ware = Warehouse.create!(name: 'Aeroporto Internacional Afonso Pena', code: 'CWB', city: 'São José dos Pinhais', area: 150_000,
                             address: 'Av. Rocha Pombo, 1000', cep: '83010-900',
                             description: 'Galpão destinado para cargas internacionais')

    sup = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                           full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

    order = Order.create!(user: any, warehouse: ware, supplier: sup, estimated_delivery_date: 1.day.from_now)

    login_as(andre)
    visit edit_order_path(order.id)

    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não possui acesso a este pedido'
  end
end
