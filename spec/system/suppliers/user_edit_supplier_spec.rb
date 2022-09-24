require 'rails_helper'

describe 'Usuário edita um fornecedor' do
  it 'a partir da página de detalhes' do
    # Arrange
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                     full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Editar'

    # Assert
    expect(page).to have_content 'Editar Fornecedor'
    expect(page).to have_field('Nome Fantasia', with: 'ACME')
    expect(page).to have_field('Razão Social', with: 'ACME LTDA')
    expect(page).to have_field('CNPJ', with: '43447216000102')
    expect(page).to have_field('Endereço', with: 'Av das Palmas, 100')
    expect(page).to have_field('Cidade', with: 'Bauru')
    expect(page).to have_field('Estado', with: 'SP')
    expect(page).to have_field('E-mail', with: 'contato@acme.com')
    expect(page).to have_field('Telefone', with: '41996686449')
  end

  it 'com sucesso' do
    # Arrange
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                     full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Editar'
    fill_in 'Nome Fantasia',	with: 'Ammec'
    fill_in 'Endereço',	with: 'Av das Palmeiras, 1520'
    fill_in 'Cidade', with: 'Ribeirão Preto'
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Fornecedor atualizado com sucesso'
    expect(page).to have_content 'Fornecedor Ammec'
    expect(page).to have_content 'Documento: 43447216000102'
    expect(page).to have_content 'Endereço: Av das Palmeiras, 1520 - Ribeirão Preto - SP'
    expect(page).to have_content 'Telefone: 41996686449'
  end

  it 'e mantém os campos obrigatórios' do
    # Arrange
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                     full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Editar'
    fill_in 'Nome Fantasia',	with: ''
    fill_in 'Endereço',	with: ''
    fill_in 'Cidade', with: ''
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Não foi possível atualizar o fornecedor'
  end
end
