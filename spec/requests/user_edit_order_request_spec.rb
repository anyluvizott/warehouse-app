require 'rails_helper'

describe 'Usuário edita um pedido' do
  it 'e não é o dono' do

    any = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')
    andre = User.create!(email: 'andre@email.com', password: 'password', name: 'André')

    ware = Warehouse.create!(name: 'Aeroporto Internacional Afonso Pena', code: 'CWB', city: 'São José dos Pinhais', area: 150_000,
                             address: 'Av. Rocha Pombo, 1000', cep: '83010-900',
                             description: 'Galpão destinado para cargas internacionais')

    sup = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                           full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

    order = Order.create!(user: any, warehouse: ware, supplier: sup, estimated_delivery_date: 1.day.from_now)

    login_as(andre)
    patch(order_path(order.id), params: { order: { supplier_id: 3 }})

    expect(response).to redirect_to(root_path)
  end
end
