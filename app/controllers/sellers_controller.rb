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
    @finantial = @seller.finantials.first

    year_revenue = @seller.revenues.first
    @year = year_revenue.information_year
    revenue_hash = year_revenue.to_hash
    @revenue_x_axis = revenue_hash.keys
    @revenue_y_axis = revenue_hash.values

    season_sales = @seller.season_sales.first
    season_sales_hash = season_sales.to_hash
    @season_sales_x_axis = season_sales_hash.keys
    @season_sales_y_axis = season_sales_hash.values

    alavancagem = {}
    endividamento = {}
    @seller.debts.each do |debt|
      if debt.alavancagem?
        alavancagem[debt.finantial_institution.name] = debt.total_amount.to_f
      else
        endividamento[debt.finantial_institution.name] = debt.total_amount.to_f
      end
    end
    @alavancagem_x_axis = alavancagem.keys
    @alavancagem_y_axis = alavancagem.values
    @endividamento_x_axis = endividamento.keys
    @endividamento_y_axis = endividamento.values

    @year_legal = @seller.legals.first

    #TODO: A view do seller_table não entende o @total_cost ?
    @total_cost = Money.new(0)
    @total_cost = @seller.finantials.first.total_wages_cost + @seller.finantials.first.rent_cost + @seller.finantials.first.cost_of_goods_sold + @seller.finantials.first.relevant_fixed_cost

    @total_operations_number = @seller.operations.count
    @total_operations_amount = Money.new(@seller.operations.sum('total_value_cents'))
    @operations_report_paid = @seller.operations.where(status: "paid").group_by_month(:deposit_date, format: "%b %y").sum("total_value_cents")
    @operations_report_paid.transform_values! {|monthly_operations_amount| monthly_operations_amount.to_f/100}
    @operations_report_not_paid = @seller.operations.where(status: "not_paid").group_by_month(:deposit_date, format: "%b %y").sum("total_value_cents")
    @operations_report_not_paid.transform_values! {|monthly_operations_amount| monthly_operations_amount.to_f/100}
    @operations_report_all_keys = @operations_report_not_paid.merge(@operations_report_paid)
    @operations_report_all_keys = @operations_report_all_keys.sort_by {|date, value| Date.strptime(date, "%b %y") }.to_h
    @operations_report_paid = merge_smaller_hash_into_bigger(@operations_report_paid, @operations_report_all_keys)
    @operations_report_not_paid = merge_smaller_hash_into_bigger(@operations_report_not_paid, @operations_report_all_keys)
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
