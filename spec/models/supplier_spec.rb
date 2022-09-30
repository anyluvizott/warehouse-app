require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when corporate name is empty' do
        # Arrange
        supplier = Supplier.new(corporate_name: '', brand_name: 'ACME', registration_number: '43447216000102',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

        # Act
        result = supplier.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when brand name is empty' do
        # Arrange
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: '', registration_number: '43447216000102',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

        # Act
        result = supplier.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when registration number is empty' do
        # Arrange
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

        # Act
        result = supplier.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when full address is empty' do
        # Arrange
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                                full_address: '', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

        # Act
        result = supplier.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when city is empty' do
        # Arrange
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                                full_address: 'Av das Palmas, 100', city: '', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

        # Act
        result = supplier.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when state is empty' do
        # Arrange
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', state: '', email: 'contato@acme.com', phone_number: '41996686449')

        # Act
        result = supplier.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when email is empty' do
        # Arrange
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: '', phone_number: '41996686449')

        # Act
        result = supplier.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when phone number is empty' do
        # Arrange
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '')

        # Act
        result = supplier.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when registration number is already in use' do
        # Arrange
        first_supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                                      full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')
        second_supplier = Supplier.new(corporate_name: 'NANA LTDA', brand_name: 'NANINHA', registration_number: '43447216000102',
                                       full_address: 'Av das Bananas, 250', city: 'Curitiba', state: 'PR', email: 'vendas@nana.com', phone_number: '41996681994')
        # Act
        result = second_supplier.valid?

        # Assert
        expect(result).to eq false
      end
    end
  end

  describe '#sup_description' do
    it 'exibe o nome fantasia, razão social e CNPJ do fornecedor' do
      sup = Supplier.new(corporate_name: 'YELLOW Distribuidora', brand_name: 'Yellow',
        registration_number: '34108887000158')

      result = sup.sup_description

      expect(result).to eq('Yellow - YELLOW Distribuidora - 34108887000158')
    end
  end
end