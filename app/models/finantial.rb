class Finantial < ApplicationRecord
  belongs_to :seller
  monetize :total_wages_cost_cents, :rent_cost_cents, :relevant_fixed_cost_cents, :cost_of_goods_sold_cents, :ebitda_cents, with_model_currency: :currency
end
