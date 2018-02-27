class Seller < ApplicationRecord
  belongs_to :client
  has_many :equity_holders
  has_many :sellers_limits
  has_many :sellers_concentrations
  has_many :operations
  has_many :invoices, through: :operations
  has_many :finantials
  has_many :debts
  has_many :season_sales
  has_many :revenues
  has_many :qualitative_information
  has_many :legals

  validates :identification_number, uniqueness: true

# TODO: refatorar seller_controller e invoices_controller para não precisar repitir essas linahs de código
  # def historical_transactions()

  #   @installments_paid_amount = Money.new(@seller.operations.joins(invoices: :installments).where(invoices: {installments: {paid: true}}).sum("value_cents"))
  #   @installments_paid_quantity = @seller.operations.joins(invoices: :installments).where(invoices: {installments: {paid: true}}).count
  #   @installments_paid = @seller.operations.joins(invoices: :installments).where(invoices: {installments: {paid: true}}).group_by_month(:deposit_date, format: "%b %y").sum("value_cents")
  #   @installments_paid.transform_values! {|monthly_amount| monthly_amount.to_f/100}

  #   time_range_future = Time.now..(Time.now + 1.year)
  #   @installments_on_date_amount = Money.new(@seller.operations.joins(invoices: :installments).where(invoices: {installments: {paid: false, due_date: time_range_future}}).sum("value_cents"))
  #   @installments_on_date_quantity = @seller.operations.joins(invoices: :installments).where(invoices: {installments: {paid: false, due_date: time_range_future}}).count
  #   @installments_on_date = @seller.operations.joins(invoices: :installments).where(invoices: {installments: {paid: false, due_date: time_range_future}}).group_by_month(:deposit_date, format: "%b %y").sum("value_cents")
  #   @installments_on_date.transform_values! {|monthly_amount| monthly_amount.to_f/100}

  #   time_range_past = (Time.now - 6.years)...(Time.now)
  #   @installments_overdue_amount = Money.new(@seller.operations.joins(invoices: :installments).where(invoices: {installments: {paid: false, due_date: time_range_past}}).sum("value_cents"))
  #   @installments_overdue_quantity = @seller.operations.joins(invoices: :installments).where(invoices: {installments: {paid: false, due_date: time_range_past}}).count
  #   @installments_overdue = @seller.operations.joins(invoices: :installments).where(invoices: {installments: {paid: false, due_date: time_range_past}}).group_by_month(:deposit_date, format: "%b %y").sum("value_cents")
  #   @installments_overdue.transform_values! {|monthly_amount| monthly_amount.to_f/100}

  #   @installments_all_keys = @installments_overdue.merge(@installments_on_date.merge(@installments_paid))
  #   @installments_all_keys = @installments_all_keys.sort_by {|date, value| Date.strptime(date, "%b %y") }.to_h
  #   @installments_paid = merge_smaller_hash_into_bigger(@installments_paid, @installments_all_keys)
  #   @installments_on_date = merge_smaller_hash_into_bigger(@installments_on_date, @installments_all_keys)
  #   @installments_overdue = merge_smaller_hash_into_bigger(@installments_overdue, @installments_all_keys)

  # end
end
