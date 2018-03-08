class Rejection < ApplicationRecord
  enum motive: {
    indisponibilidade_de_capital: 0,
    limite_de_concentração_excedido: 1,
    cedente_apresenta_alto_risco_de_crédito: 2,
    sacado_apresenta_alto_risco_de_crédito: 3,
    suspeita_de_fraude: 4,
    outra_opção: 5
  }

  belongs_to :invoice
  belongs_to :rejector, class_name: "Client"
end
