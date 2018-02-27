class Installment < ApplicationRecord
  # enum liquidation_status: {
  #   registred: 0,
  #   waiting_for_deposit: 1,
  #   pending_payment: 2,
  #   paid: 3,
  # }
  belongs_to :invoice, optional: true
  delegate :order, to: :invoice, allow_nil: true
  # We need this so that the program understands that value is a Money object
  monetize :value_cents, with_model_currency: :currency

  def outstanding_days
    due_date > Time.now ? TimeDifference.between(due_date, Time.now).in_days : 0
  end

  def closure_outstanding_days
    TimeDifference.between(due_date, order.created_at).in_days
  end

  def interest
    value * ((1.05 ** (outstanding_days / 30)) - 1)
  end

  def ad_valorem
    value * ((1.005 ** (outstanding_days / 30)) - 1)
  end

  def iof
    (0.000041 * outstanding_days) * value
  end
end
