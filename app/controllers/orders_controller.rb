class OrdersController < ApplicationController
  def create
    # binding.pry
    order = Order.new(order_params)
    order.buyer = current_user.client

    ActiveRecord::Base.transaction do
      order.save!

      order.invoices.each do |invoice|
        invoice.bought!
        invoice.buyer = current_user.client
        invoice.save!
      end
    end

    PurchaseMailer.purchase_notification(order.buyer, order).deliver_now

    # order.invoices.each do |invoice|
    #   PurchaseMailer.purchase_notification(invoice.buyer, invoice).deliver_now
    # end

    flash[:notice] = "Compra bem-sucedida!"

    redirect_to invoices_path
  end

  private

  def order_params
    params.require(:order).permit(invoice_ids: [])
  end
end
