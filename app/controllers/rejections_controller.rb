class RejectionsController < ApplicationController
  def create
    ActiveRecord::Base.transaction do
      invoice_params['invoice_ids'].each do |invoice_id|
        rejection = Rejection.new(rejection_params)
        rejection.rejector = current_user.client
        rejection.invoice_id = invoice_id
        rejection.save!
      end
    end

    flash[:notice] = "Rejeição registrada!"

    redirect_to invoices_path
  end

  private

  def invoice_params
    params.require(:rejection).permit(invoice_ids: [])
  end

  def rejection_params
    params.require(:rejection).permit( :motive, :motive_detail)
  end
end
