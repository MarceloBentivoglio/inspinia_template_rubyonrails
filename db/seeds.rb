# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'Cleaning database...'
EquityHolder.destroy_all
SellersLimit.destroy_all
SellersConcentration.destroy_all
Invoice.destroy_all
QualitativeInformation.destroy_all
Revenue.destroy_all
SeasonSale.destroy_all
Debt.destroy_all
Finantial.destroy_all
Operation.destroy_all
Seller.destroy_all
User.destroy_all
Client.destroy_all


puts 'Creating new Client...'
client = Client.create!(name: 'MVP Invest', cnpj: '23198636000195', available_funds: Money.new(1000000))

puts 'Creating new User...'
user = User.create!(client: client, email: 'test@email.com', password: '123456')

puts 'Creating new Sellers...'
seller1 = Seller.create!(
  identification_number: "12254565000198",
  company_nickname: "Le Wagon",
  company_name: "Fast Food Ensinos Computacionais Limitada",
  client: client,
  email: contato@me.com.br,
  address: "Rua Mourato Coelho",
  address_number: "1438",
  address_2: "Bairro: Vila Madalena",
  phone_number: "+ 55 11 99830-8090",
  incorporation_date: "2016",
)
seller2 = Seller.create!(identification_number: "25462169000165", company_name: "Enterprise RH Ltda", client: client)


puts 'Creating new Operation...'
operation = Operation.create!(seller: seller1, closure_date: Time.now, total_value: Money.new(12000), average_outstanding_days: 38)

# puts 'Creating new Invoices...'

puts 'Creating Finantials...'
finantials2017 = Finantial.create!(
  seller: seller1,
  production_economics_cycle_description: "Ensino de programação para público em geral. Trabalha com batch de alunos. Alunos pagam em parcelas. Cada batch dura 2 meses e o parcelamento é feito dentro deste período. 3 Batchs por ano",
  employee_quantity: 3,
  total_wages_cost: Money.new(5000),
  rent_cost: Money.new(4000),
  relevant_fixed_cost: Money.new(500),
  cost_of_goods_sold: Money.new(2000),
  ebitda: Money.new(400000),
  information_year: "2017",
)

puts 'Creating Finantial Institutions...'
finantial_institutions = [
  'Banco do Brasil',
  'Itaú',
  'Santander',
  'Original',
]

finantial_institutions.each do |finantial_institution|
  FinantialInstitution.create!(name: finantial_institution)
end

puts 'Creating Debt Types...'
debt_types = [
  'Empréstimo de longo prazo',
  'Crédito de para capital de giro',
  'Adiantamento de recebíveis'
]

debt_types.each do |debt_type|
  DebtType.create!(name: debt_type)
end


puts 'Creating Debts...'
debts_2017 = Debt.create!(
  seller: seller1,
  finantial_institution: FinantialInstitution.last,
  debt_type: DebtType.last,
  total_amount: Money.new(-10000),
  balance_amount: Money.new(-4000),
  installments_quantity: Money.new(12),
  information_year: "2017",
)

puts 'Creating Season Sales...'
season_sales_2017 = SeasonSale.create!(
  seller: seller1,
  jan: true,
  feb: true,
  mar: false,
  apr: false,
  may: true,
  jun: true,
  jul: false,
  aug: false,
  sep: true,
  oct: true,
  nov: false,
  dec: false,
  information_year: "2017",
)

puts 'Creating Revenues...'
revenues_2017 = Revenue.create!(
  seller: seller1,
  jan: Money.new(100000),
  feb: Money.new(100000),
  mar: Money.new(0),
  apr: Money.new(0),
  may: Money.new(100000),
  jun: Money.new(100000),
  jul: Money.new(0),
  aug: Money.new(0),
  sep: Money.new(100000),
  oct: Money.new(100000),
  nov: Money.new(0),
  dec: Money.new(0),
  information_year: "2017",
)

puts 'Creating Qualitative Information...'
qualitative_information_2017 = QualitativeInformation.create!(
  seller: seller1,
  address_verification: true,
  address_verification_observation: "visita ao local",
  website: 'https://www.lewagon.com',
  google: 'https://www.google.com.br/search?q=lewagon&oq=lewagon&aqs=chrome..69i57j69i60l3j69i65l2.3825j0j1&sourceid=chrome&ie=UTF-8',
  linkedin: 'https://www.linkedin.com/school/5046700/',
  facebook: 'https://www.facebook.com/lewagon/?ref=br_rs&brand_redir=124305831394417',
  corporate_email: 'Mathieu.laroux@lewagon.com.br',
  reclame_aqui: 'https://www.reclameaqui.com.br/busca/?q=le%20wagon',
  reclame_aqui_complaints_quantity: 0,
  reclame_aqui_answered_complaints: 0,
  google_maps: 'https://www.google.com.br/maps/place/Le+Wagon+S%C3%A3o+Paulo+Coding+Bootcamp/@-23.555991,-46.6946815,17z/data=!3m1!4b1!4m5!3m4!1s0x94ce57bc5392ac8f:0x39c0e547e7b82d85!8m2!3d-23.555991!4d-46.6924928?hl=en',
  information_year: '2017',
)

puts 'Creating Legals...'
legal_2017 = Legal.create!(
  seller: seller1,
  civil_suits_quantity: 1,
  civil_suits_amount: Money.new(100000),
  labor_suits_quantity: 2,
  labor_suits_amount: Money.new(200000),
  penal_suits_quantity: 3,
  penal_suits_amount: Money.new(300000),
  fiscal_suits_quantity: 4,
  fiscal_suits_amount: Money.new(400000),
  enforcement_monition_suits_quantity: nil,
  enforcement_monition_suits_amount: nil,
  information_year: '2017',
)


puts 'If you are reading this... your login details is'
puts 'test@email.com'
puts 'password: 123456'

puts 'THANKS :*'
