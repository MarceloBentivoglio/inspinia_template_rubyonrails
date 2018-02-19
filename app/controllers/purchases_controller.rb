class PurchasesController < ApplicationController
  def create
    buyer = Client.find(params[:buyer])
    invoice = Invoice.find(params[:invoice])
    Purchase.create!(buyer: buyer, invoice: invoice)
    redirect_to root_path
  end
end
