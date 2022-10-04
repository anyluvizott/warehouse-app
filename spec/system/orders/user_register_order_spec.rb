require 'rails_helper'

describe 'Usuário cadastra um pedido' do
  it 'e deve estar autenticado' do
    visit root_path
    click_on 'Registrar Pedido'

    expect(current_path).to eq new_user_session_path
  end
  it 'com sucesso' do
    # Arrange
    user = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

    warehouse1 = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                   address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')

    warehouse2 = Warehouse.create!(name: 'Aeroporto Internacional Afonso Pena', code: 'CWB',
                                   city: 'São José dos Pinhais', area: 150_000, address: 'Av. Rocha Pombo, 1000', cep: '83010-900', description: 'Galpão destinado para cargas internacionais')

    supplier2 = Supplier.create!(corporate_name: 'YELLOW Distribuidora', brand_name: 'Yellow',
                                 registration_number: '34108887000158', full_address: 'Rua Maestro Francisco Antonello, 382', city: 'Curitiba', state: 'PR', email: 'vendas@yellow.com', phone_number: '41996681994')

    supplier1 = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                                 full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC1234567')
    # Act
    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select 'GRU - Aeroporto SP', from: 'Galpão Destino'
    select supplier1.sup_description, from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega',	with: 1.day.from_now
    click_on 'Gravar'

    result = 1.day.from_now

    # Assert
    expect(page).to have_content 'Pedido registrado com sucesso'
    expect(page).to have_content 'Pedido ABC1234567'
    expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
    expect(page).to have_content 'Fornecedor: ACME LTDA'
    expect(page).to have_content 'Usuário Responsável: Anyelly - any@email.com'
    expect(page).not_to have_content 'Aeroporto Internacional Afonso Pena'
    expect(page).not_to have_content 'YELLOW Distribuidora'
  end

  it 'com a data de estimativa de entrega para um dia passado' do
    user = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

    warehouse1 = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                   address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')

    warehouse2 = Warehouse.create!(name: 'Aeroporto Internacional Afonso Pena', code: 'CWB',
                                   city: 'São José dos Pinhais', area: 150_000, address: 'Av. Rocha Pombo, 1000', cep: '83010-900', description: 'Galpão destinado para cargas internacionais')

    supplier2 = Supplier.create!(corporate_name: 'YELLOW Distribuidora', brand_name: 'Yellow',
                                 registration_number: '34108887000158', full_address: 'Rua Maestro Francisco Antonello, 382', city: 'Curitiba', state: 'PR', email: 'vendas@yellow.com', phone_number: '41996681994')

    supplier1 = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                                 full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select 'GRU - Aeroporto SP', from: 'Galpão Destino'
    select supplier1.sup_description, from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega',	with: 1.day.ago
    click_on 'Gravar'

    expect(page).to have_content 'Data Prevista de Entrega deve ser futura'
    expect(page).to have_content 'Não foi possível cadastrar seu pedido'
    expect(page).not_to have_content 'Pedido registrado com sucesso'
  end

  it 'e não informa a data de entrega' do
    user = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

    warehouse1 = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                   address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')

    supplier1 = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                                 full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select 'GRU - Aeroporto SP', from: 'Galpão Destino'
    select supplier1.sup_description, from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega',	with: nil
    click_on 'Gravar'

    expect(page).to have_content 'Data Prevista de Entrega não pode ficar em branco'
    expect(page).to have_content 'Não foi possível cadastrar seu pedido'
    expect(page).not_to have_content 'Pedido registrado com sucesso'
  end
end
