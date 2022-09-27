require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
                                    registration_number: '34875523000101', full_address: 'Av Nacoes Unidas, 1000', city: 'São Paulo',
                                    state: 'SP', email: 'sac@samsung.com.br', phone_number: '42998566548')

        prod_model = ProductModel.new(name: '', weight: 8000, width: 70, height: 45, depth: 10, sku: 'SAMSU-TV40-60-5502-P',
                                      supplier:)

        result = prod_model.valid?

        expect(result).to eq false
      end

      it 'false when weight is empty' do
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
                                    registration_number: '34875523000101', full_address: 'Av Nacoes Unidas, 1000', city: 'São Paulo',
                                    state: 'SP', email: 'sac@samsung.com.br', phone_number: '42998566548')

        prod_model = ProductModel.new(name: 'TV 32', weight: '', width: 70, height: 45, depth: 10, sku: 'SAMSU-TV40-60-5502-P',
                                      supplier:)

        result = prod_model.valid?

        expect(result).to eq false
      end

      it 'false when width is empty' do
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
                                    registration_number: '34875523000101', full_address: 'Av Nacoes Unidas, 1000', city: 'São Paulo',
                                    state: 'SP', email: 'sac@samsung.com.br', phone_number: '42998566548')

        prod_model = ProductModel.new(name: 'TV 32', weight: 8000, width: '', height: 45, depth: 10, sku: 'SAMSU-TV40-60-5502-P',
                                      supplier:)

        result = prod_model.valid?

        expect(result).to eq false
      end

      it 'false when height is empty' do
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
                                    registration_number: '34875523000101', full_address: 'Av Nacoes Unidas, 1000', city: 'São Paulo',
                                    state: 'SP', email: 'sac@samsung.com.br', phone_number: '42998566548')

        prod_model = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: '', depth: 10, sku: 'SAMSU-TV40-60-5502-P',
                                      supplier:)

        result = prod_model.valid?

        expect(result).to eq false
      end

      it 'false when depth is empty' do
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
                                    registration_number: '34875523000101', full_address: 'Av Nacoes Unidas, 1000', city: 'São Paulo',
                                    state: 'SP', email: 'sac@samsung.com.br', phone_number: '42998566548')

        prod_model = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: '', sku: 'SAMSU-TV40-60-5502-P',
                                      supplier:)

        result = prod_model.valid?

        expect(result).to eq false
      end

      it 'false when SKU is empty' do
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
                                    registration_number: '34875523000101', full_address: 'Av Nacoes Unidas, 1000', city: 'São Paulo',
                                    state: 'SP', email: 'sac@samsung.com.br', phone_number: '42998566548')

        prod_model = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: '',
                                      supplier:)

        result = prod_model.valid?

        expect(result).to eq false
      end

      it 'false when supplier is empty' do
        prod_model = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'SAMSU-TV40-60-5502-P',
                                      supplier: nil)

        result = prod_model.valid?

        expect(result).to eq false
      end

      it 'false when sku is alredy in use' do
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
                                    registration_number: '34875523000101', full_address: 'Av Nacoes Unidas, 1000', city: 'São Paulo',
                                    state: 'SP', email: 'sac@samsung.com.br', phone_number: '42998566548')

        first_product = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'SAMSU-TV40-60-5502-P',
                                             supplier:)

        second_product = ProductModel.new(name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15, depth: 20, sku: 'SAMSU-TV40-60-5502-P',
                                          supplier:)
        result = second_product.valid?

        expect(result).to eq false
      end

      it 'false when weight is zero' do
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
                                    registration_number: '34875523000101', full_address: 'Av Nacoes Unidas, 1000', city: 'São Paulo',
                                    state: 'SP', email: 'sac@samsung.com.br', phone_number: '42998566548')

        prod_model = ProductModel.new(name: 'TV 32', weight: 0, width: 10, height: 45, depth: 10, sku: 'SAMSU-TV40-60-5502-P',
                                      supplier:)

        result = prod_model.valid?

        expect(result).to eq false
      end

      it 'false when weight is less than zero' do
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
                                    registration_number: '34875523000101', full_address: 'Av Nacoes Unidas, 1000', city: 'São Paulo',
                                    state: 'SP', email: 'sac@samsung.com.br', phone_number: '42998566548')

        prod_model = ProductModel.new(name: 'TV 32', weight: -1, width: 10, height: 45, depth: 10, sku: 'SAMSU-TV40-60-5502-P',
                                      supplier:)

        result = prod_model.valid?

        expect(result).to eq false
      end

      it 'false when width is zero' do
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
                                    registration_number: '34875523000101', full_address: 'Av Nacoes Unidas, 1000', city: 'São Paulo',
                                    state: 'SP', email: 'sac@samsung.com.br', phone_number: '42998566548')

        prod_model = ProductModel.new(name: 'TV 32', weight: 8000, width: 0, height: 45, depth: 10, sku: 'SAMSU-TV40-60-5502-P',
                                      supplier:)

        result = prod_model.valid?

        expect(result).to eq false
      end

      it 'false when width is less than zero' do
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
                                    registration_number: '34875523000101', full_address: 'Av Nacoes Unidas, 1000', city: 'São Paulo',
                                    state: 'SP', email: 'sac@samsung.com.br', phone_number: '42998566548')

        prod_model = ProductModel.new(name: 'TV 32', weight: 8000, width: -1, height: 45, depth: 10, sku: 'SAMSU-TV40-60-5502-P',
                                      supplier:)

        result = prod_model.valid?

        expect(result).to eq false
      end

      it 'false when height is zero' do
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
                                    registration_number: '34875523000101', full_address: 'Av Nacoes Unidas, 1000', city: 'São Paulo',
                                    state: 'SP', email: 'sac@samsung.com.br', phone_number: '42998566548')

        prod_model = ProductModel.new(name: 'TV 32', weight: 8000, width: 10, height: 0, depth: 10, sku: 'SAMSU-TV40-60-5502-P',
                                      supplier:)

        result = prod_model.valid?

        expect(result).to eq false
      end

      it 'false when height is less than zero' do
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
                                    registration_number: '34875523000101', full_address: 'Av Nacoes Unidas, 1000', city: 'São Paulo',
                                    state: 'SP', email: 'sac@samsung.com.br', phone_number: '42998566548')

        prod_model = ProductModel.new(name: 'TV 32', weight: 8000, width: 10, height: -1, depth: 10, sku: 'SAMSU-TV40-60-5502-P',
                                      supplier:)

        result = prod_model.valid?

        expect(result).to eq false
      end

      it 'false when depth is zero' do
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
                                    registration_number: '34875523000101', full_address: 'Av Nacoes Unidas, 1000', city: 'São Paulo',
                                    state: 'SP', email: 'sac@samsung.com.br', phone_number: '42998566548')

        prod_model = ProductModel.new(name: 'TV 32', weight: 8000, width: 0, height: 45, depth: 0, sku: 'SAMSU-TV40-60-5502-P',
                                      supplier:)

        result = prod_model.valid?

        expect(result).to eq false
      end

      it 'false when depth is less than zero' do
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
                                    registration_number: '34875523000101', full_address: 'Av Nacoes Unidas, 1000', city: 'São Paulo',
                                    state: 'SP', email: 'sac@samsung.com.br', phone_number: '42998566548')

        prod_model = ProductModel.new(name: 'TV 32', weight: 8000, width: 10, height: 45, depth: -1, sku: 'SAMSU-TV40-60-5502-P',
                                      supplier:)

        result = prod_model.valid?

        expect(result).to eq false
      end
    end
  end
end
