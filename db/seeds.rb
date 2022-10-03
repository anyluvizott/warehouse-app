# Criando alguns galpões de exemplo:
ware1 = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                  description: 'Galpão destinado para cargas internacionais')

ware2 = Warehouse.create!(name: 'Aeroporto Internacional Afonso Pena', code: 'CWB', city: 'São José dos Pinhais', area: 150_000,
                  address: 'Av. Rocha Pombo, 1000', cep: '83010-900',
                  description: 'Galpão destinado para cargas internacionais')

# Criando alguns fornecedores de exemplo:
sup1 = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                        full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

sup2 = Supplier.create!(corporate_name: 'YELLOW Distribuidora', brand_name: 'Yellow', registration_number: '34108887000158',
                        full_address: 'Rua Maestro Francisco Antonello, 382', city: 'Curitiba', state: 'PR', email: 'vendas@yellow.com', phone_number: '41996681994')

# Criando alguns Modelos de Produto de exemplo:
prod1 = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'SAMSU-TV40-60-5502-P',
                     supplier: sup1)

prod2 = ProductModel.create!(name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15, depth: 20, sku: 'SAMSU-SOBA-80-6345-V',
                     supplier: sup1)

# Criando um user de exemplo:                 
user = User.create!(email: 'any@email.com', password: 'password', name: 'Anyelly')

# Criando alguns pedidos de exemplo:
order = Order.create!(user: user, warehouse: ware2, supplier: sup2, estimated_delivery_date: 1.day.from_now)
order = Order.create!(user: user, warehouse: ware2, supplier: sup1, estimated_delivery_date: 2.days.from_now)
order = Order.create!(user: user, warehouse: ware1, supplier: sup2, estimated_delivery_date: 3.days.from_now)