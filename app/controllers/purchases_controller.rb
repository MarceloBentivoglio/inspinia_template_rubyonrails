class PurchasesController < ApplicationController
  def create
    buyer = Client.find(params[:buyer])
    invoice = Invoice.find(params[:invoice])
    offer = Offer.find_by(invoice: invoice)
    offer.destroy
    Purchase.create!(buyer: buyer, invoice: invoice)
    redirect_to root_path
  end
end
