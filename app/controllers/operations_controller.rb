class OperationsController < ApplicationController
  def index

  end

  def new
  end

  def create
  end

  def show
    @operation = Operation.find(params[:id])
    @seller = @operation.seller
    @invoices = @operation.invoices
  end
end
