require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        # Arrange
        warehouse = Warehouse.new(name: '', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000,
                                  description: 'Alguma descrição')

        # Act
        result = warehouse.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when code is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: '', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000,
                                  description: 'Alguma descrição')

        # Act
        result = warehouse.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when address is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: '', cep: '25000-000', city: 'Rio', area: 1000,
                                  description: 'Alguma descrição')

        # Act
        result = warehouse.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when cep is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '', city: 'Rio', area: 1000,
                                  description: 'Alguma descrição')

        # Act
        result = warehouse.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when city is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '25000-000', city: '', area: 1000,
                                  description: 'Alguma descrição')

        # Act
        result = warehouse.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when area is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: '',
                                  description: 'Alguma descrição')

        # Act
        result = warehouse.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when description is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000,
                                  description: '')

        # Act
        result = warehouse.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when code is already in use' do
        # Arrange
        first_warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000,
                                           description: 'Alguma descrição')

        second_warehouse = Warehouse.new(name: 'Niteroi', code: 'RIO', address: 'Avenida', cep: '35000-000', city: 'Niteroi', area: 1500,
                                         description: 'Outra descrição')

        # Act
        result = second_warehouse.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when name is already in use' do
        # Arrange
        first_warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000,
                                           description: 'Alguma descrição')

        second_warehouse = Warehouse.new(name: 'Rio', code: 'CWB', address: 'Avenida', cep: '35000-000', city: 'Niteroi', area: 1500,
                                         description: 'Outra descrição')

        # Act
        result = second_warehouse.valid?

        # Assert
        expect(result).to eq false
      end
    end
  end

  describe '#full_description' do
    it 'exibe o nome e o código' do
      w = Warehouse.new(name: 'Galpão Cuiabá', code: 'CBA')

      result = w.full_description()

      expect(result).to eq('CBA - Galpão Cuiabá')
    end
  end
end
