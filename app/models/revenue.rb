class Revenue < ApplicationRecord
  belongs_to :seller
  monetize :jan_cents, :feb_cents, :mar_cents, :apr_cents, :may_cents, :jun_cents, :jul_cents, :aug_cents, :sep_cents, :oct_cents, :nov_cents, :dec_cents, with_model_currency: :currency

end
