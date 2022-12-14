require 'rails_helper'

describe 'Usuário vê fornecedores' do
  it 'a partir do menu' do
    # Arrange
    user = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

    # Act
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end

    # Assert
    expect(current_path).to eq suppliers_path
  end

  it 'com sucesso' do
    # Arrange
    user = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                     full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

    Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark',
                     registration_number: '15371752000136', full_address: 'Torre da Indústria, 1', city: 'Teresinha', state: 'PI', email: 'vendas@park.com.br', phone_number: '41996681994')

    # Act
    login_as(user)
    visit root_path
    click_on 'Fornecedores'

    # Assert
    expect(page).to have_content('Fornecedores')
    expect(page).to have_content('ACME')
    expect(page).to have_content('Bauru - SP')
    expect(page).to have_content('Spark')
    expect(page).to have_content('Teresinha - PI')
  end

  it 'e não existem fornecedores cadastrados' do
    # Arrange
    user = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

    # Act
    login_as(user)
    visit root_path
    click_on 'Fornecedores'

    # Assert
    expect(page).to have_content('Não existem fornecedores cadastrados')
  end
end
