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

  private

  def seller_params
    params.require(:seller).permit(:identification_number, :company_name, :company_nickname, :business_entity, :registration_number, :nire, :incorporation_date, :zip_code, :address, :address_number, :neighborhood, :address_2, :state, :city, :corporate_capital, :activity, :cnae, :tax_option)
  end
end
