# puts 'Cleaning database...'
# EquityHolder.destroy_all
# SellersLimit.destroy_all
# SellersConcentration.destroy_all
# Installment.destroy_all
# Invoice.destroy_all
# QualitativeInformation.destroy_all
# Revenue.destroy_all
# SeasonSale.destroy_all
# Debt.destroy_all
# Finantial.destroy_all
# Operation.destroy_all
# Seller.destroy_all
# Payer.destroy_all
# User.destroy_all
# Client.destroy_all


# puts 'Creating new Client...'
# client = Client.create!(
#   name: 'MVP Invest',
#   cnpj: '23198636000195',
#   available_funds: Money.new(100000000)
#   )

# client2 = Client.create!(
#   name: 'Sabia Fomento Mercantil Limitada',
#   cnpj: '24648847000145',
#   available_funds: Money.new(3000000000)
#   )

# puts 'Creating new User...'
# user = User.create!(email: 'test@email.com', password: '123123', client: client, admin: true)

# puts 'Creating Finantial Institutions...'
# f1 = FinantialInstitution.create!(name: 'Itaú')
# f2 = FinantialInstitution.create!(name: 'Bradesco')
# f3 = FinantialInstitution.create!(name: 'Caixa Econômica Federal')
# f4 = FinantialInstitution.create!(name: 'Banco do Brasil')
# f5 = FinantialInstitution.create!(name: 'BNDES')
# f6 = FinantialInstitution.create!(name: 'Santander')
# f7 = FinantialInstitution.create!(name: 'Receita Federal')
# f8 = FinantialInstitution.create!(name: 'MVP Fomento Mercantil')
# f9 = FinantialInstitution.create!(name: 'Sabia Fomento Mercantil')
# f10 = FinantialInstitution.create!(name: 'FIDC Federal Invest')
# f11 = FinantialInstitution.create!(name: 'BV Financeira')

# puts 'Creating Debt Types...'
# d1 = DebtType.create!(name: 'Financiamento Imobiliario')
# d2 = DebtType.create!(name: 'Financiamento Automotivo')
# d3 = DebtType.create!(name: 'Capital de Giro')
# d4 = DebtType.create!(name: 'Refis')
# d5 = DebtType.create!(name: 'Antecipação de Recebíveis')
# d6 = DebtType.create!(name: 'Cheque Especial')
# d7 = DebtType.create!(name: 'Conta Garantida')

LegacyImportationController.new.import_legacy_data({user: user})

# seller1 = Seller.where("company_name like 'BIORT%'").first

# puts 'Creating Offers...'
# most_expensive_invoices = Invoice.all.order(total_value_cents: :DESC).limit(20).map {|invoice| invoice.for_sale!}


# puts 'Creating finantials for seller1...'
# finantial1 = Finantial.create!(
#   seller: seller1,
#   production_economics_cycle_description: 'Biort distribui produtos hospitalares para os maiores hospitais de São Paulo. Possui como principais clientes, Rede Dor São Luiz, Cruzeiro do Sul, Christóvão da Gama, entre outros.',
#   employee_quantity: 16,
#   total_wages_cost: Money.new(85000),
#   rent_cost: Money.new(7000),
#   relevant_fixed_cost: Money.new(15000),
#   cost_of_goods_sold: Money.new(150000),
#   information_year: '2017',
#   )

# puts 'Creating debts for seller1...'

# puts 'Creating "endividamento"....'

# debt1 = Debt.create!(
#   seller: seller1,
#   finantial_institution: f1,
#   debt_type: d6,
#   total_amount: Money.new(0),
#   balance_amount: Money.new(13821),
#   installments_quantity: 1,
#   information_year: '2017',
#   )

# debt2 = Debt.create!(
#   seller: seller1,
#   finantial_institution: f1,
#   debt_type: d7,
#   total_amount: Money.new(0),
#   balance_amount: Money.new(1750000),
#   installments_quantity: 1,
#   information_year: '2017',
#   )

# debt3 = Debt.create!(
#   seller: seller1,
#   finantial_institution: f1,
#   debt_type: d3,
#   total_amount: Money.new(0),
#   balance_amount: Money.new(21322100),
#   installments_quantity: 24,
#   information_year: '2017',
#   )

# debt4 = Debt.create!(
#   seller: seller1,
#   finantial_institution: f11,
#   debt_type: d2,
#   total_amount: Money.new(0),
#   balance_amount: Money.new(1340700),
#   installments_quantity: 10,
#   information_year: '2017',
#   )

# debt5 = Debt.create!(
#   seller: seller1,
#   finantial_institution: f2,
#   debt_type: d2,
#   total_amount: Money.new(0),
#   balance_amount: Money.new(6200000),
#   installments_quantity: 10,
#   information_year: '2017',
#   )

# puts 'Creating "alavancagem"....'

# ala1 = Debt.create!(
#   seller: seller1,
#   finantial_institution: f1,
#   debt_type: d5,
#   total_amount: Money.new(0),
#   balance_amount: Money.new(9662700),
#   installments_quantity: 10,
#   information_year: '2017',
#   )


# puts 'Creating Qualitative Informations for seller1...'
# qi = QualitativeInformation.create!(
#   seller: seller1,
#   address_verification: true,
#   address_verification_observation: 'Escritório bem localizado e bem organizado.',
#   website: 'não possui',
#   google: 'pouca informação',
#   linkedin: 'não possui',
#   facebook: 'não possui',
#   corporate_email: '@biort.com.br',
#   reclame_aqui: 'não possui reclamações',
#   reclame_aqui_complaints_quantity: 0,
#   reclame_aqui_answered_complaints: 0,
#   google_maps: 'atualizado',
#   information_year: '2017'
#   )

# puts 'Creating Season Sales for seller1...'
# season = SeasonSale.create!(
#   seller: seller1,
#   jan: false,
#   feb: false,
#   mar: false,
#   apr: true,
#   may: true,
#   jun: false,
#   jul: false,
#   aug: false,
#   sep: false,
#   oct: true,
#   nov: true,
#   dec: true,
#   information_year: '2017'
#   )

# puts 'Creating Revenues... seller1'
# r1 = Revenue.create!(
#   seller: seller1,
#   jan: Money.new(0),
#   feb: Money.new(27229918),
#   mar: Money.new(34753828),
#   apr: Money.new(31158778),
#   may: Money.new(33890187),
#   jun: Money.new(36392975),
#   jul: Money.new(49849299),
#   aug: Money.new(30644302),
#   sep: Money.new(25117165),
#   oct: Money.new(22608075),
#   nov: Money.new(17294601),
#   dec: Money.new(17642850),
#   information_year: "2017"
# )
# r2 = Revenue.create!(
#   seller: seller1,
#   jan: Money.new(27448150),
#   information_year: "2018"
# )

# puts 'Creating Legals... seller1'
#   l1 = Legal.create!(
#     seller: seller1,
#     civil_suits_quantity: 0,
#     civil_suits_amount: Money.new(0),
#     labor_suits_quantity: 0,
#     labor_suits_amount: Money.new(0),
#     penal_suits_quantity: 0,
#     penal_suits_amount: Money.new(0),
#     fiscal_suits_quantity: 2,
#     fiscal_suits_amount: Money.new(13583500),
#     enforcement_monition_suits_quantity: 0,
#     enforcement_monition_suits_amount: Money.new(0),
#     information_year: "2017",
#   )


# # seller2 = Seller.create!(
# #   identification_number: "12254565000198",
# #   company_name: "Fast Food Ensinos Computacionais Limitada",
# #   company_nickname: "Le Wagon",
# #   business_entity: "TBD",
# #   registration_number: "45646546546",
# #   nire: "4564654654",
# #   incorporation_date: "2016",
# #   zip_code: "4564564",
# #   address: "Rua Mourato Coelho",
# #   address_number: "1438",
# #   neighborhood: "Vila Madalena",
# #   address_2: "Apart 35",
# #   state: "SP",
# #   city: "São Paulo",
# #   corporate_capital: "5000000",
# #   activity: "",
# #   cnae: "",
# #   tax_option: "",
# #   client: client,
# #   email: "contato@me.com.br",
# #   phone_number: "+ 55 11 99830-8090",
# #   )

# # puts 'Creating new Payers...'
# # payer1 = Payer.create!(
# #   identification_number: "23156412000156",
# #   company_nickname: "Ge Force GTX",
# #   company_name: "Nvidia Geforce gtx 970m Ltda",
# #   email: "contato@nvidia.com.br",
# #   address: "Rua Bandeira Paulista",
# #   address_number: "140",
# #   neighborhood: "Vila Olimpia",
# #   phone_number: "+ 55 11 4411-5050",
# #   incorporation_date: "1975"
# #   )
# # payer2 = Payer.create!(
# #   identification_number: "25144236000166",
# #   company_nickname: "BenQ",
# #   company_name: "BenQ Monitors and Equips SA.",
# #   email: "contato@benq.com.br",
# #   address: "Alameda Santos",
# #   address_number: "1550",
# #   neighborhood: "Cerqueira Cesar",
# #   phone_number: "+ 55 11 95587-2363",
# #   incorporation_date: "1992"
# #   )

# # puts 'Creating new Operation...'
# # operation = Operation.create!(seller: seller1, closure_date: Time.now, total_value: Money.new(12000), average_outstanding_days: 38)

# puts 'Creating new Invoices...'
# invoice = Invoice.create!(
#   operation: Operation.last,
#   payer: Payer.last,
#   seller: Operation.last.seller,
#   number: "40012",
#   confirmed: true,
#   notified: true,
#   total_value: Money.new(10000)
# )

# # invoice2 = Invoice.create!(operation: operation, payer: payer2, invoice_number: "40015", status: "disponivel", delivery_status: true, confirmed: true, notified: true, average_outstanding_days: 24, total_value: Money.new(4000))


# puts 'Creating new Installments...'
# i = Installment.create!(
#   invoice: invoice,
#   number: "40012/1",
#   value: Money.new(5000),
#   due_date: Time.now,
#   paid: false
# )

# i2 = Installment.create!(
#   invoice: invoice,
#   number: "40012/2",
#   value: Money.new(5000),
#   due_date: Time.now,
#   paid: true
# )
# # i3 = Installment.create!(invoice: invoice2, number: "40015/1", value: Money.new(1000), due_date: Time.now + 30)
# # i4 = Installment.create!(invoice: invoice2, number: "40015/2", value: Money.new(1000), due_date: Time.now + 58)
# # i5 = Installment.create!(invoice: invoice2, number: "40015/3", value: Money.new(1000), due_date: Time.now + 88)
# # i6 = Installment.create!(invoice: invoice2, number: "40015/4", value: Money.new(1000), due_date: Time.now + 102)


# # puts 'Creating Finantials...'
# # finantials2017 = Finantial.create!(
# #   seller: seller2,
# #   production_economics_cycle_description: "Ensino de programação para público em geral. Trabalha com batch de alunos. Alunos pagam em parcelas. Cada batch dura 2 meses e o parcelamento é feito dentro deste período. 3 Batchs por ano",
# #   employee_quantity: 3,
# #   total_wages_cost: Money.new(5000),
# #   rent_cost: Money.new(4000),
# #   relevant_fixed_cost: Money.new(500),
# #   cost_of_goods_sold: Money.new(2000),
# #   ebitda: Money.new(400000),
# #   information_year: "2017",
# # )



# # puts 'Creating Revenues...'
# # revenues_2017 = Revenue.create!(
# #   seller: seller2,
# #   jan: Money.new(100000),
# #   feb: Money.new(100000),
# #   mar: Money.new(0),
# #   apr: Money.new(0),
# #   may: Money.new(100000),
# #   jun: Money.new(100000),
# #   jul: Money.new(0),
# #   aug: Money.new(0),
# #   sep: Money.new(100000),
# #   oct: Money.new(100000),
# #   nov: Money.new(0),
# #   dec: Money.new(0),
# #   information_year: "2017",
# # )

# # puts 'Creating Qualitative Information...'
# # qualitative_information_2017 = QualitativeInformation.create!(
# #   seller: seller2,
# #   address_verification: true,
# #   address_verification_observation: "visita ao local",
# #   website: 'https://www.lewagon.com',
# #   google: 'https://www.google.com.br/search?q=lewagon&oq=lewagon&aqs=chrome..69i57j69i60l3j69i65l2.3825j0j1&sourceid=chrome&ie=UTF-8',
# #   linkedin: 'https://www.linkedin.com/school/5046700/',
# #   facebook: 'https://www.facebook.com/lewagon/?ref=br_rs&brand_redir=124305831394417',
# #   corporate_email: 'Mathieu.laroux@lewagon.com.br',
# #   reclame_aqui: 'https://www.reclameaqui.com.br/busca/?q=le%20wagon',
# #   reclame_aqui_complaints_quantity: 0,
# #   reclame_aqui_answered_complaints: 0,
# #   google_maps: 'https://www.google.com.br/maps/place/Le+Wagon+S%C3%A3o+Paulo+Coding+Bootcamp/@-23.555991,-46.6946815,17z/data=!3m1!4b1!4m5!3m4!1s0x94ce57bc5392ac8f:0x39c0e547e7b82d85!8m2!3d-23.555991!4d-46.6924928?hl=en',
# #   information_year: '2017',
# # )

# # puts 'Creating Debts to seller2...'
# # debt2 = Debt.create!(
# #   seller: seller2,
# #   finantial_institution: f3,
# #   debt_type: d5,
# #   total_amount: Money.new(250000),
# #   balance_amount: Money.new(150000),
# #   installments_quantity: 10,
# #   information_year: '2017',
# #   )

# # puts 'Creating Legals...'
# # legal_2017 = Legal.create!(
# #   seller: seller2,
# #   civil_suits_quantity: 1,
# #   civil_suits_amount: Money.new(100000),
# #   labor_suits_quantity: 2,
# #   labor_suits_amount: Money.new(200000),
# #   penal_suits_quantity: 3,
# #   penal_suits_amount: Money.new(300000),
# #   fiscal_suits_quantity: 4,
# #   fiscal_suits_amount: Money.new(400000),
# #   enforcement_monition_suits_quantity: nil,
# #   enforcement_monition_suits_amount: nil,
# #   information_year: '2017',
# # )

# # puts 'Creating Legals...'
# # l1 = Legal.create!(
# #   seller: seller1,
# #   civil_suits_quantity: 1,
# #   civil_suits_amount: Money.new(100000),
# #   labor_suits_quantity: 2,
# #   labor_suits_amount: Money.new(200000),
# #   penal_suits_quantity: 3,
# #   penal_suits_amount: Money.new(300000),
# #   fiscal_suits_quantity: 4,
# #   fiscal_suits_amount: Money.new(400000),
# #   enforcement_monition_suits_quantity: nil,
# #   enforcement_monition_suits_amount: nil,
# #   information_year: '2017',
# # )

# puts 'If you are reading this... your login details is'
# puts 'test@email.com'
# puts 'password: 123123'

# puts 'THANKS :*'
