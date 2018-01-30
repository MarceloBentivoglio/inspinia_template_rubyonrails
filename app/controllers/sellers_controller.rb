class SellersController < ApplicationController
  def new
    @seller = Seller.new
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
    #TODO get the Finantial from the year that the user wants. in fact the description should be on the seller not in the finantital
    @finantial = @seller.finantials.first
    #TODO get the revenue from the year that the user wants
    year_revenue = @seller.revenues.first
    @year = year_revenue.information_year
    @revenue = extract_revenue_in_integer(year_revenue)

  end

  private

  def extract_revenue_in_integer(revenue_object)
    revenue_array = []
    revenue_array.push(revenue_object.jan.to_s.to_i)
    revenue_array.push(revenue_object.feb.to_s.to_i)
    revenue_array.push(revenue_object.mar.to_s.to_i)
    revenue_array.push(revenue_object.apr.to_s.to_i)
    revenue_array.push(revenue_object.may.to_s.to_i)
    revenue_array.push(revenue_object.jun.to_s.to_i)
    revenue_array.push(revenue_object.jul.to_s.to_i)
    revenue_array.push(revenue_object.aug.to_s.to_i)
    revenue_array.push(revenue_object.sep.to_s.to_i)
    revenue_array.push(revenue_object.oct.to_s.to_i)
    revenue_array.push(revenue_object.nov.to_s.to_i)
    revenue_array.push(revenue_object.dec.to_s.to_i)
  end

  def seller_params
    params.require(:seller).permit(:identification_number, :company_name, :company_nickname, :business_entity, :registration_number, :nire, :incorporation_date, :zip_code, :address, :address_number, :neighborhood, :address_2, :state, :city, :corporate_capital, :activity, :cnae, :tax_option)
  end
end
