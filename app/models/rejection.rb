class Rejection < ApplicationRecord
  enum motive: {
    lack_of_capital: 0,
    concentration_problem: 1,
    seller_problem: 2,
    payer_problem: 3,
  }

  belongs_to :invoice
  belongs_to :rejector, class_name: "Client"
end
