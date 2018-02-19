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

    # @total_operations_number = @payer.operations.count
    # @total_operations_amount = Money.new(@payer.operations.sum('total_value_cents'))
    # @operations_report = @payer.operations.group_by_month(:deposit_date, format: "%b %y").sum("total_value_cents")
    # @operations_report.transform_values! {|monthly_operations_amount| monthly_operations_amount.to_f/100}
  end

  private

  def payer_params
    params.require(:payer).permit(:identification_number, :company_name, :company_nickname, :business_entity, :registration_number, :nire, :incorporation_date, :zip_code, :address, :address_number, :neighborhood, :address_2, :state, :city, :corporate_capital, :activity, :cnae, :tax_option)
  end
end
