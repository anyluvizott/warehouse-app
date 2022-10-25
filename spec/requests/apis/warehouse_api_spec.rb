require 'rails_helper'

describe 'Warehouse API' do
  context 'GET/api/v1/warehouses/1' do
    it 'success' do
      # Arrange
      warehouse = Warehouse.create!(name: 'Aeroporto do Rio de Janeiro', code: 'SDU', city: 'Rio de Janeiro', area: 95_800,
                                    address: 'Praça Sen. Salgado Filho, s/n - Centro', cep: '20021-340',
                                    description: 'Galpão destinada para cargas da região do Rio de Janeiro')

      # Act
      get "/api/v1/warehouses/#{warehouse.id}"

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'

      json_response = JSON.parse(response.body)

      expect(json_response['name']).to eq 'Aeroporto do Rio de Janeiro'
      expect(json_response['code']).to eq 'SDU'
      expect(json_response['city']).to eq 'Rio de Janeiro'
      expect(json_response['area']).to eq 95_800
      expect(json_response['address']).to eq 'Praça Sen. Salgado Filho, s/n - Centro'
      expect(json_response['cep']).to eq '20021-340'
      expect(json_response['description']).to eq 'Galpão destinada para cargas da região do Rio de Janeiro'
      expect(json_response.keys).not_to include 'created_at'
      expect(json_response.keys).not_to include 'updated_at'
    end

    it 'fail if warehouse not found' do
      get '/api/v1/warehouses/9999999'

      expect(response.status).to eq 404
    end
  end

  context 'GET /api/v1/warehouses' do
    it 'sucess' do
      warehouse_one = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                        address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                        description: 'Galpão destinado para cargas internacionais')

      warerehouse_two = Warehouse.create!(name: 'Aeroporto Internacional Afonso Pena', code: 'CWB', city: 'São José dos Pinhais', area: 150_000,
                                          address: 'Av. Rocha Pombo, 1000', cep: '83010-900',
                                          description: 'Galpão destinado para cargas internacionais')

      get '/api/v1/warehouses'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response[0]['name']).to eq 'Aeroporto SP'
      expect(json_response[1]['name']).to eq 'Aeroporto Internacional Afonso Pena'
    end

    it 'return empty if there is no warehouse' do
      get '/api/v1/warehouses'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end
  end
end
