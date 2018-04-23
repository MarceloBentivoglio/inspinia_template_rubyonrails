class Client < ApplicationRecord
  has_many :users
  has_many :sellers
  has_many :bought_invoices, class_name: "Invoice", foreign_key: :buyer_id, dependent: :destroy
  has_many :owned_invoices, class_name: "Invoice", foreign_key: :owner_id, dependent: :destroy
  has_many :rejections, class_name: "Rejection", foreign_key: :rejector_id, dependent: :destroy
  # Não tenho que colocar as orders aqui também não?
  monetize :available_funds_cents, with_model_currency: :currency
end
