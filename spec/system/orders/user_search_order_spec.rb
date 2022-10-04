require 'rails_helper'

describe 'Usuário busca por um pedido' do
  it 'a partir do menu' do
    user = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

    login_as(user)
    visit root_path

    within('header nav') do
      expect(page).to have_field('Buscar Pedido')
      expect(page).to have_button('Buscar')
    end
  end

  it 'e deve estar autenticada' do
    visit root_path

    within('header nav') do
      expect(page).not_to have_field('Buscar Pedido')
      expect(page).not_to have_button('Buscar')
    end
  end

  it 'e encontra um pedido' do
    user = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')
    warehouse = Warehouse.create!(name: 'Aeroporto Internacional Afonso Pena', code: 'CWB', city: 'São José dos Pinhais', area: 150_000,
                                  address: 'Av. Rocha Pombo, 1000', cep: '83010-900',
                                  description: 'Galpão destinado para cargas internacionais')

    sup1 = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                            full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

    order = Order.create!(user:, warehouse:, supplier: sup1, estimated_delivery_date: 1.day.from_now)

    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido',	with: order.code
    click_on 'Buscar'

    expect(page).to have_content "Resultados da Busca por: #{order.code}"
    expect(page).to have_content '1 pedido encontrado'
    expect(page).to have_content "Código: #{order.code}"
    expect(page).to have_content 'Galpão Destino: CWB - Aeroporto Internacional Afonso Pena'
    expect(page).to have_content 'Fornecedor: ACME LTDA'
  end

  it 'e encontra multiplos pedidos' do
    user = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

    ware1 = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                              address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                              description: 'Galpão destinado para cargas internacionais')

    ware2 = Warehouse.create!(name: 'Aeroporto Internacional Afonso Pena', code: 'CWB', city: 'São José dos Pinhais', area: 150_000,
                              address: 'Av. Rocha Pombo, 1000', cep: '83010-900',
                              description: 'Galpão destinado para cargas internacionais')

    sup1 = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                            full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

    allow(SecureRandom).to receive(:alphanumeric).and_return('GRU1234567')
    order1 = Order.create!(user:, warehouse: ware1, supplier: sup1, estimated_delivery_date: 1.day.from_now)

    allow(SecureRandom).to receive(:alphanumeric).and_return('GRU6789123')
    order2 = Order.create!(user:, warehouse: ware1, supplier: sup1, estimated_delivery_date: 1.day.from_now)

    allow(SecureRandom).to receive(:alphanumeric).and_return('CWB1234567')
    order3 = Order.create!(user:, warehouse: ware2, supplier: sup1, estimated_delivery_date: 1.day.from_now)

    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido',	with: 'GRU'
    click_on 'Buscar'

    expect(page).to have_content('2 pedidos encontrados')
    expect(page).to have_content('GRU1234567')
    expect(page).to have_content('GRU6789123')
    expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'

    expect(page).not_to have_content('CWB1234567')
    expect(page).not_to have_content 'Galpão Destino: CWB -Aeroporto Internacional Afonso Pena'
  end
end
