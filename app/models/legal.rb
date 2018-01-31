class Legal < ApplicationRecord
  belongs_to :seller
  monetize :civil_suits_amount_cents, :labor_suits_amount_cents, :penal_suits_amount_cents, :fiscal_suits_amount_cents, :enforcement_monition_suits_amount_cents, with_model_currency: :currency
end
