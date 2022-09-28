require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    # Arrange

    # Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma conta'
    fill_in "E-mail",	with: "any@email.com"
    fill_in "Senha",	with: "password" 
    click_on 'Criar conta'

    #Assert
    expect(page).to have_content 'any@gmail.com'
    expect(page).to have_button 'Sair' 
  end
end