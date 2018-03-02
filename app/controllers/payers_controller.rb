class PayersController < ApplicationController
  def new
    @payer = Payer.new
  end

  def create
    @payer = Payer.new(payer_params)
    @payer.save
    if @payer.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @payer = Payer.find(params[:id])
    #TODO get the data from the year that the user wants. in fact the description should be on the payer not in the finantital
    # @finantial = @payer.finantials.first

    @invoices_count = @payer.invoices.count
    @invoices_amount = @payer.invoices.sum('total_value_cents')


    # @total_operations_number = @payer.operations.count
    # @total_operations_amount = Money.new(@payer.operations.sum('total_value_cents'))
    # @operations_report = @payer.invoices.group_by_month(:deposit_date, format: "%b %y").sum("total_value_cents")
    # @operations_report.transform_values! {|monthly_operations_amount| monthly_operations_amount.to_f/100}


    @installments_paid_amount = Money.new(@payer.invoices.joins(:installments).where(installments: {paid: true}).sum("value_cents"))
    @installments_paid_quantity = @payer.invoices.joins(:installments).where(installments: {paid: true}).count
    @installments_paid = @payer.invoices.joins(:installments).where(installments: {paid: true}).group_by_month(:due_date, format: "%b %y").sum("value_cents")
    @installments_paid.transform_values! {|monthly_amount| monthly_amount.to_f/100}

    time_range_future = Time.now..(Time.now + 1.year)
    @installments_on_date_amount = Money.new(@payer.invoices.joins(:installments).where(installments: {paid: false, due_date: time_range_future}).sum("value_cents"))
    @installments_on_date_quantity = @payer.invoices.joins(:installments).where(installments: {paid: false, due_date: time_range_future}).count
    @installments_on_date = @payer.invoices.joins(:installments).where(installments: {paid: false, due_date: time_range_future}).group_by_month(:due_date, format: "%b %y").sum("value_cents")
    @installments_on_date.transform_values! {|monthly_amount| monthly_amount.to_f/100}

    time_range_past = (Time.now - 6.years)...(Time.now)
    @installments_overdue_amount = Money.new(@payer.invoices.joins(:installments).where(installments: {paid: false, due_date: time_range_past}).sum("value_cents"))
    @installments_overdue_quantity = @payer.invoices.joins(:installments).where(installments: {paid: false, due_date: time_range_past}).count
    @installments_overdue = @payer.invoices.joins(:installments).where(installments: {paid: false, due_date: time_range_past}).group_by_month(:due_date, format: "%b %y").sum("value_cents")
    @installments_overdue.transform_values! {|monthly_amount| monthly_amount.to_f/100}

    @installments_all_keys = @installments_overdue.merge(@installments_on_date.merge(@installments_paid))
    @installments_all_keys = @installments_all_keys.sort_by {|date, value| Date.strptime(date, "%b %y") }.to_h
    @installments_paid = merge_smaller_hash_into_bigger(@installments_paid, @installments_all_keys)
    @installments_on_date = merge_smaller_hash_into_bigger(@installments_on_date, @installments_all_keys)
    @installments_overdue = merge_smaller_hash_into_bigger(@installments_overdue, @installments_all_keys)
  end

  private

  def merge_smaller_hash_into_bigger(small, big)
    new_hash = {}
    big.each do |key, value|
      new_hash[key] = small[key] ? small[key] : 0
    end
    return new_hash
  end

  def payer_params
    params.require(:payer).permit(:identification_number, :company_name, :company_nickname, :business_entity, :registration_number, :nire, :incorporation_date, :zip_code, :address, :address_number, :neighborhood, :address_2, :state, :city, :corporate_capital, :activity, :cnae, :tax_option)
  end
end
