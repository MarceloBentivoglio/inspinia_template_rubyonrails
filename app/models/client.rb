class Client < ApplicationRecord
  has_many :users
  has_many :sellers
  has_many :purchases, class_name: "Purchase", foreign_key: :buyer_id, dependent: :destroy
  has_many :bought_invoices, class_name: "Invoice", foreign_key: :buyer_id, dependent: :destroy
  # Não tenho que colocar as orders aqui também não?
  monetize :available_funds_cents, with_model_currency: :currency
end
