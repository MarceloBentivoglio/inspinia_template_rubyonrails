class Seller < ApplicationRecord
  belongs_to :client
  has_many :equity_holders
  has_many :sellers_limits
  has_many :sellers_concentrations
  has_many :operations
  has_many :invoices
  has_many :finantials
  has_many :debts
  has_many :season_sales
  has_many :revenues
  has_many :qualitative_information
  has_many :legals

  validates :identification_number, uniqueness: true
  monetize :limit_cents, with_model_currency: :currency


  def name
    "#{id} - #{company_nickname}"
  end

  def total_leverage
    debts.where(debt_type: 5).sum('balance_amount_cents') / 100
  end

  def total_debt
    debts.sum('balance_amount_cents') / 100 - total_leverage
  end

  def total_costs
    if finantials[0]
      finantials[0].total_wages_cost_cents + finantials[0].rent_cost_cents + finantials[0].relevant_fixed_cost_cents + finantials[0].cost_of_goods_sold_cents
    end
  end

  def average_revenue
    revenues.where(id: 1).pluck(:jan_cents,
                                :feb_cents,
                                :mar_cents,
                                :apr_cents,
                                :may_cents,
                                :jun_cents,
                                :jul_cents,
                                :aug_cents,
                                :sep_cents,
                                :oct_cents,
                                :nov_cents,
                                :dec_cents).map(&:sum).sum / 100 / 11

  end

  def used_limit
    used = Money.new(invoices.joins(:installments).where(installments: {paid: false}).sum(:value_cents))
    {
      absolute: used,
      relative: used.cents.to_f/limit.cents,
    }
  end


end
