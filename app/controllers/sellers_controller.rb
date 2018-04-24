class SellersController < ApplicationController
  def new
    @seller = Seller.new
  end

  def index
    @sellers = Seller.all
    @payers = Payer.all
  end

  def create
    @seller = Seller.new(seller_params)
    @seller.client = current_user.client
    @seller.save
    if @seller.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @seller = Seller.find(params[:id])
    #TODO get the data from the year that the user wants. in fact the description should be on the seller not in the finantital

    year_revenue = @seller.revenues.first
    if year_revenue
      @year = year_revenue.information_year
      revenue_hash = year_revenue.to_hash
      @revenue_x_axis = revenue_hash.keys
      @revenue_y_axis = revenue_hash.values
    end

    season_sales = @seller.season_sales.first
    if season_sales
      season_sales_hash = season_sales.to_hash
      @season_sales_x_axis = season_sales_hash.keys
      @season_sales_y_axis = season_sales_hash.values
    end

    alavancagem = {}
    endividamento = {}
    @seller.debts.each do |debt|
      if debt.alavancagem?
        alavancagem[debt.finantial_institution.name] = debt.balance_amount.to_f
      else
        endividamento[debt.finantial_institution.name] = debt.balance_amount.to_f
      end
    end
    @alavancagem_x_axis = alavancagem.keys
    @alavancagem_y_axis = alavancagem.values
    @endividamento_x_axis = endividamento.keys
    @endividamento_y_axis = endividamento.values

    @year_legal = @seller.legals.first

    #TODO: A view do seller_table não entende o @total_cost ?
    @finantials = @seller.finantials.first
    @total_cost = Money.new(0)
    if @finantials
      @total_cost = @finantials.total_wages_cost + @finantials.rent_cost + @finantials.cost_of_goods_sold + @finantials.relevant_fixed_cost
      @production_economics_cycle_description = @finantials.production_economics_cycle_description
    end
    @installments_paid_amount = Money.new(@seller.invoices.joins(:installments).where(installments: {paid: true}).sum("value_cents"))
    @installments_paid_quantity = @seller.invoices.joins(:installments).where(installments: {paid: true}).count
    @installments_paid = @seller.invoices.joins(:installments).where(installments: {paid: true}).group_by_month(:due_date, format: "%b %y").sum("value_cents")
    @installments_paid.transform_values! {|monthly_amount| monthly_amount.to_f/100}

    time_range_future = Time.now..(Time.now + 1.year)
    @installments_on_date_amount = Money.new(@seller.invoices.joins(:installments).where(installments: {paid: false, due_date: time_range_future}).sum("value_cents"))
    @installments_on_date_quantity = @seller.invoices.joins(:installments).where(installments: {paid: false, due_date: time_range_future}).count
    @installments_on_date = @seller.invoices.joins(:installments).where(installments: {paid: false, due_date: time_range_future}).group_by_month(:due_date, format: "%b %y").sum("value_cents")
    @installments_on_date.transform_values! {|monthly_amount| monthly_amount.to_f/100}

    time_range_past = (Time.now - 6.years)...(Time.now)
    @installments_overdue_amount = Money.new(@seller.invoices.joins(:installments).where(installments: {paid: false, due_date: time_range_past}).sum("value_cents"))
    @installments_overdue_quantity = @seller.invoices.joins(:installments).where(installments: {paid: false, due_date: time_range_past}).count
    @installments_overdue = @seller.invoices.joins(:installments).where(installments: {paid: false, due_date: time_range_past}).group_by_month(:due_date, format: "%b %y").sum("value_cents")
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

  def seller_params
    params.require(:seller).permit(:identification_number, :company_name, :company_nickname, :business_entity, :registration_number, :nire, :incorporation_date, :zip_code, :address, :address_number, :neighborhood, :address_2, :state, :city, :corporate_capital, :activity, :cnae, :tax_option)
  end
end
