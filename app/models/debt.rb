class Debt < ApplicationRecord
  belongs_to :seller
  belongs_to :finantial_institution
  belongs_to :debt_type

  monetize :total_amount_cents, :balance_amount_cents, with_model_currency: :currency
end
