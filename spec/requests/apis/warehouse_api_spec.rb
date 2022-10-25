require 'rails_helper'

describe 'Warehouse API' do
  context 'GET/api/v1/warehouse/1' do
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

      expect(json_response["name"]).to eq 'Aeroporto do Rio de Janeiro'
      expect(json_response["code"]).to eq 'SDU'
    end
  end
end
