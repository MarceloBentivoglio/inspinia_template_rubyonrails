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

  private

  def payer_params
    params.require(:payer).permit(:identification_number, :company_name, :company_nickname, :business_entity, :registration_number, :nire, :incorporation_date, :zip_code, :address, :address_number, :neighborhood, :address_2, :state, :city, :corporate_capital, :activity, :cnae, :tax_option)
  end
end
