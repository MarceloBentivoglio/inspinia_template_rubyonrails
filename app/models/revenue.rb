class Revenue < ApplicationRecord
  belongs_to :seller
  monetize :jan_cents, :feb_cents, :mar_cents, :apr_cents, :may_cents, :jun_cents, :jul_cents, :aug_cents, :sep_cents, :oct_cents, :nov_cents, :dec_cents, with_model_currency: :currency

  def to_hash
   {
      "Jan" => jan.to_s.to_i,
      "Fev" => feb.to_s.to_i,
      "Mar" => mar.to_s.to_i,
      "Abr" => apr.to_s.to_i,
      "Mai" => may.to_s.to_i,
      "Jun" => jun.to_s.to_i,
      "Jul" => jul.to_s.to_i,
      "Ago" => aug.to_s.to_i,
      "Set" => sep.to_s.to_i,
      "Out" => oct.to_s.to_i,
      "Nov" => nov.to_s.to_i,
      "Dez" => dec.to_s.to_i,
    }
  end
end
