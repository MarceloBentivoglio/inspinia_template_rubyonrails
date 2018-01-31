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
    #TODO get the legal from the year that the user wants
    @year_legal = @seller.legals.first
  end

  private

  def extract_revenue_in_integer(revenue_object)
    revenue_array = []
    revenue_array.push(["Jan", revenue_object.jan.to_s.to_i])
    revenue_array.push(["Fev", revenue_object.feb.to_s.to_i])
    revenue_array.push(["Mar", revenue_object.mar.to_s.to_i])
    revenue_array.push(["Abr", revenue_object.apr.to_s.to_i])
    revenue_array.push(["Mai", revenue_object.may.to_s.to_i])
    revenue_array.push(["Jun", revenue_object.jun.to_s.to_i])
    revenue_array.push(["Jul", revenue_object.jul.to_s.to_i])
    revenue_array.push(["Ago", revenue_object.aug.to_s.to_i])
    revenue_array.push(["Set", revenue_object.sep.to_s.to_i])
    revenue_array.push(["Out", revenue_object.oct.to_s.to_i])
    revenue_array.push(["Nov", revenue_object.nov.to_s.to_i])
    revenue_array.push(["Dez", revenue_object.dec.to_s.to_i])


  end

  def seller_params
    params.require(:seller).permit(:identification_number, :company_name, :company_nickname, :business_entity, :registration_number, :nire, :incorporation_date, :zip_code, :address, :address_number, :neighborhood, :address_2, :state, :city, :corporate_capital, :activity, :cnae, :tax_option)
  end
end
