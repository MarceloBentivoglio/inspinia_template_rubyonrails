class Installment < ApplicationRecord
  belongs_to :invoice, optional: true
  # We need this so that the program understands that value is a Money object
  monetize :value_cents, :interest_cents, :ad_valorem_cents, with_model_currency: :currency
end
