class Client < ApplicationRecord
  has_many :users
  has_many :sellers
  monetize :available_funds_cents, with_model_currency: :currency
end
