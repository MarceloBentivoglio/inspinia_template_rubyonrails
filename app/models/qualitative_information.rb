class QualitativeInformation < ApplicationRecord
  belongs_to :seller
  monetize :law_suits_amount_cents, with_model_currency: :currency
end
