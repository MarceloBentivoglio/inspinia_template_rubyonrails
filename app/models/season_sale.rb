class SeasonSale < ApplicationRecord
  belongs_to :seller
  def to_hash
    {
      "Jan" => jan ? 1 : 0,
      "Fev" => feb ? 1 : 0,
      "Mar" => mar ? 1 : 0,
      "Abr" => apr ? 1 : 0,
      "Mai" => may ? 1 : 0,
      "Jun" => jun ? 1 : 0,
      "Jul" => jul ? 1 : 0,
      "Ago" => aug ? 1 : 0,
      "Set" => sep ? 1 : 0,
      "Out" => oct ? 1 : 0,
      "Nov" => nov ? 1 : 0,
      "Dez" => dec ? 1 : 0,
    }
  end
end
