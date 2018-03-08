class OrdersController < ApplicationController
  def create
    order = Order.new(order_params)
    order.buyer = current_user.client

    ActiveRecord::Base.transaction do
      order.save!

      order.invoices.each do |invoice|
        invoice.sold!
        invoice.buyer = current_user.client
        invoice.save!
      end
    end

    if PurchaseMailer.purchase_notification(order.buyer, order).deliver
      flash[:notice] = "Compra bem-sucedida!"
      redirect_to invoices_path
    else
      flash[:alert] = "Email não enviado!"
      redirect_to invoices_path
    end



    # order.invoices.each do |invoice|
    #   PurchaseMailer.purchase_notification(invoice.buyer, invoice).deliver_now
    # end


  end

  private

  def order_params
    params.require(:order).permit(invoice_ids: [])
  end
end
