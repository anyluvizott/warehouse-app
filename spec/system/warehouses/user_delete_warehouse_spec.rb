require 'rails_helper'

describe 'Usuario remove um galpão' do
  it 'com sucesso' do
    # Arrange
    user = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

    w = Warehouse.create!(name: 'Cuiaba', code: 'CWB', area: 10_000, cep: '56000-000', city: 'Cuiaba',
                          description: 'Galpão no centro do pais', address: 'Av dos Jacarés, 1000')

    # Act
    login_as(user)
    visit root_path
    click_on 'Cuiaba'
    click_on 'Remover'

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).not_to have_content 'Cuiaba'
    expect(page).not_to have_content 'CWB'
  end

  it 'e não apaga os outros galpões' do
    # Arrange
    user = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

    first_warehouse = Warehouse.create!(name: 'Cuiaba', code: 'CWB', area: 10_000, cep: '56000-000', city: 'Cuiaba',
                                        description: 'Galpão no centro do pais', address: 'Av dos Jacarés, 1000')
    second_warehouse = Warehouse.create!(name: 'Belo Horizonte', code: 'BHZ', area: 20_000, cep: '46000-000', city: 'Belo Horizonte',
                                         description: 'Galpão para cargas mineiras', address: 'Av Tiradentes, 20')

    # Act
    login_as(user)
    visit root_path
    click_on 'Cuiaba'
    click_on 'Remover'

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).to have_content 'Belo Horizonte'
    expect(page).not_to have_content 'Cuiaba'
  end
end
