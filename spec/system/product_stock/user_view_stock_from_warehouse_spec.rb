require 'rails_helper'

describe 'Usuário vê o estoque' do
  it 'na tela do galpão' do
    user = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

    order = Order.create!(user:, warehouse:, supplier:,
                          estimated_delivery_date: 1.day.from_now)

    produto_tv = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'SAMSU-TV40-60-5502-P',
                                      supplier:)

    produto_soundbar = ProductModel.create!(name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15, depth: 20, sku: 'SAMSU-SOBA-80-6345-V',
                                            supplier:)

    produto_notebook = ProductModel.create!(name: 'Notebook i5 16GB RAM', weight: 200, width: 40, height: 15, depth: 20, sku: 'SAMSU-NOTE-5I-6345-V',
                                            supplier:)

    3.times { StockProduct.create!(order:, warehouse:, product_model: produto_tv) }
    2.times { StockProduct.create!(order:, warehouse:, product_model: produto_notebook) }

    # Act
    login_as(user)
    visit root_path
    click_on 'Aeroporto SP'

    # Assert
    within('section#stock_products') do
      expect(page).to have_content 'Itens em Estoque'
      expect(page).to have_content '3 x SAMSU-TV40-60-5502-P'
      expect(page).to have_content '2 x SAMSU-NOTE-5I-6345-V'
      expect(page).not_to have_content 'SAMSU-SOBA-80-6345-V'
    end
  end

  it 'e dá baixa em um item' do
    user = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

    order = Order.create!(user:, warehouse:, supplier:,
                          estimated_delivery_date: 1.day.from_now)

    produto_tv = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'SAMSU-TV40-60-5502-P',
                                      supplier:)

    2.times { StockProduct.create!(order:, warehouse:, product_model: produto_tv) }

    # Act
    login_as(user)
    visit root_path
    click_on 'Aeroporto SP'
    select 'SAMSU-TV40-60-5502-P', from: 'Item para Saída'
    fill_in 'Destinatário',	with: 'Maria Ferreira'
    fill_in 'Endereço Destino',	with: 'Rua das Palmeiras, 100 - Campinas - São Paulo'
    click_on 'Confirmar Retirada'

    # Assert
    expect(current_path).to eq warehouse_path(warehouse.id)
    expect(page).to have_content 'Item retirado com sucesso'
    expect(page).to have_content '1 x SAMSU-TV40-60-5502-P'
  end
end
