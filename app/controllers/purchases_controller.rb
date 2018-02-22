class PurchasesController < ApplicationController
  def create
    purchase = Purchase.new(purchase_params)
    purchase.buyer = current_user.client

    ActiveRecord::Base.transaction do
      purchase.save!
      purchase.invoice.offer.destroy
    end

    PurchaseMailer.purchase_notification(purchase.buyer, purchase.invoice).deliver_now

    redirect_back(fallback_location: root_path)
  end

  private

  def purchase_params
    params.require(:purchase).permit(:invoice_id)
  end
end
