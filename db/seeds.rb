# Criando um user de exemplo:                 
user = User.create!(email: 'ana@email.com', password: 'password', name: 'Ana')

# Criando alguns galpões de exemplo:
warehouse_one = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                  description: 'Galpão destinado para cargas internacionais')

warehouse_two = Warehouse.create!(name: 'Aeroporto Internacional Afonso Pena', code: 'CWB', city: 'São José dos Pinhais', area: 150_000,
                  address: 'Av. Rocha Pombo, 1000', cep: '83010-900',
                  description: 'Galpão destinado para cargas internacionais')

warehouse_three = Warehouse.create!(name: 'Aeroporto do Rio de Janeiro', code: 'SDU', city: 'Rio de Janeiro', area: 95_800,
                  address: 'Praça Sen. Salgado Filho, s/n - Centro', cep: '20021-340',
                  description: 'Galpão destinada para cargas da região do Rio de Janeiro')

warehouse_four = Warehouse.create!(name: 'Aeroporto Internacional de Brasília', code: 'BSB', city: 'Brasília', area: 100_000,
                  address: 'Lago Sul, Brasília', cep: '71608-900',
                  description: 'Galpão destinado para cargas da região de Brasília')

# Criando alguns fornecedores de exemplo:
supplier_one = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
                        full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com', phone_number: '41996686449')

supplier_two = Supplier.create!(corporate_name: 'YELLOW Distribuidora', brand_name: 'Yellow', registration_number: '34108887000158',
                        full_address: 'Rua Maestro Francisco Antonello, 382', city: 'Curitiba', state: 'PR', email: 'vendas@yellow.com', phone_number: '41996681994')

supplier_three = Supplier.create!(corporate_name: 'HAYAMAX LTDA', brand_name: 'Hayamax', registration_number: '59528502000132',
                        full_address: 'Rua João Marques de Nóbrega, 300', city: 'Ibiporã', state: 'PR', email: 'vendas@hayamax.com', phone_number: '41996682557')

# Criando alguns Modelos de Produto de exemplo:
product_one = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'SAMSU-TV40-60-5502-P',
                     supplier: supplier_one)

product_two = ProductModel.create!(name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15, depth: 20, sku: 'SAMSU-SOBA-80-6345-V',
                     supplier: supplier_one)

product_three= ProductModel.create!(name: 'Kindle 10a.', weight: 300, width: 20, height: 30, depth: 10, sku: 'KINDL-10AG-10-8596-P',
                     supplier: supplier_two)

product_four = ProductModel.create!(name: 'Echo Dot - Smart Speaker', weight: 328, width: 100, height: 100, depth: 89, sku: 'ECHOD-DOT4-04-4589-B',
                     supplier: supplier_two)

product_five = ProductModel.create!(name: 'Impressora DeskJet Ink - Wi-Fi Scanner', weight: 3400, width: 42, height: 15, depth: 30, sku: '7FR22-DISK-22-7845-P',
                     supplier: supplier_three)

# Criando alguns pedidos de exemplo:
order_one = Order.create!(user: user, warehouse: warehouse_one, supplier: supplier_one, estimated_delivery_date: 1.day.from_now)
order_two = Order.create!(user: user, warehouse: warehouse_two, supplier: supplier_one, estimated_delivery_date: 2.days.from_now)
order_three = Order.create!(user: user, warehouse: warehouse_three, supplier: supplier_two, estimated_delivery_date: 3.days.from_now)
order_four = Order.create!(user: user, warehouse: warehouse_four, supplier: supplier_three, estimated_delivery_date: 3.days.from_now)
