class OrdersController < ApplicationController
  def create
    order = Order.new(order_params)
    order.buyer = current_user.client

    ActiveRecord::Base.transaction do
      order.save!

      order.invoices.each do |invoice|
        purchase = Purchase.new(invoice: invoice)
        purchase.buyer = current_user.client
        purchase.save!
        purchase.invoice.offer.destroy
      end
    end

    order.invoices.each do |invoice|
      purchase = invoice.purchase
      PurchaseMailer.purchase_notification(purchase.buyer, purchase.invoice).deliver_now
    end

    flash[:notice] = "Compra bem-sucedida!"

    redirect_to invoices_path
  end

  private

  def order_params
    params.require(:order).permit(invoice_ids: [])
  end
end
