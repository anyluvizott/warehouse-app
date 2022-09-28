require 'rails_helper'

describe 'Usuário vê modelos de produto' do
  it 'se estiver autenticado' do
    # Arrange

    # Act
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end

    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'a partir do menu' do
    # Arrange
    user = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

    # Act
    login_as(user)
    visit root_path

    within('nav') do
      click_on 'Modelos de Produtos'
    end

    # Assert
    expect(current_path).to eq product_models_path
  end

  it 'com sucesso' do
    # Arrange
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
                                registration_number: '34875523000101', full_address: 'Av Nacoes Unidas, 1000', city: 'São Paulo',
                                state: 'SP', email: 'sac@samsung.com.br', phone_number: '42998566548')

    ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'SAMSU-TV40-60-5502-P',
                         supplier:)

    ProductModel.create!(name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15, depth: 20, sku: 'SAMSU-SOBA-80-6345-V',
                         supplier:)
    user = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

    # Act
    login_as(user)
    visit root_path

    within('nav') do
      click_on 'Modelos de Produtos'
    end

    # Assert
    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'SAMSU-TV40-60-5502-P'
    expect(page).to have_content 'Samsung'
    expect(page).to have_content 'SoundBar 7.1 Surround'
    expect(page).to have_content 'SAMSU-SOBA-80-6345-V'
    expect(page).to have_content 'Samsung'
  end

  it 'e não existem produtos cadastrados' do
    user = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

    login_as(user)
    visit root_path

    click_on 'Modelos de Produtos'

    expect(page).to have_content 'Nenhum modelo de produto cadastrado'
  end
end
