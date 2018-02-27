class InvoicesController < ApplicationController
  def index
    @offered_invoices = Invoice.for_sale.includes(operation: :seller)
    @purchased_invoices = Invoice.bought.includes(operation: :seller).where(buyer: current_user.client)
    # TODO: verificar se há melhora de performance com a linha de código abaixo
    # @purchased_invoices = Invoice.bought.includes(operation: {seller: {client: :user}}).where(buyer: current_user.client)
  end

  def new
    @invoice = Invoice.new
    @invoice.installments.build
    @invoice.build_payer
    @invoice.build_operation
  end

  def show
    @invoice = Invoice.find(params[:id])
    @seller = @invoice.operation.seller
    @payer = @invoice.payer
    @installments = @invoice.installments

    @operations_report = @seller.operations.group_by_month(:deposit_date, last: 8, format: "%b %y").sum("total_value_cents")
    @operations_report.transform_values! {|monthly_operations_amount| monthly_operations_amount.to_f/100}

    if request.xhr?
      render layout: false
    end
  end


  def load_invoice_from_xml
    if params[:invoice][:xml_file].present?
      @invoice = Invoice.from_file(params[:invoice][:xml_file])
      render :new
      return
    else
      redirect_to new_invoice_path
    end
  end

  # TODO: refactor with the Invoice class method self.extract_payer_info
  def create
    invoice = Invoice.new(invoice_and_installments_params)

    invoice.operation = Operation.new(operation_params[:operation_attributes])

    payer_identification_number = payer_params[:payer_attributes][:identification_number]
    if Payer.exists?(identification_number: payer_identification_number)
      payer = Payer.find_by_identification_number(payer_identification_number)
    else
      payer = Payer.new(payer_params[:payer_attributes])
    end

    seller_identification_number = seller_params[:operation_attributes][:seller_attributes][:identification_number]
    if Seller.exists?(identification_number: seller_identification_number)
      seller = Seller.find_by_identification_number(seller_identification_number)
    else
      seller = Seller.new(seller_params[:operation_attributes][:seller_attributes])
      seller.client = current_user.client
    end

    invoice.payer = payer
    invoice.operation.seller = seller
    ActiveRecord::Base.transaction do
      payer.save!
      seller.save!
      invoice.save!
    end

    redirect_to invoices_path
  end

  def checkout
    @invoices = Invoice.find(JSON.parse(params[:invoices_ids]))
  end

  private

  def invoice_and_installments_params
    # In the strong parameters we need to pass the attributes of intallments so that the invoice form can understand it
    params
      .require(:invoice)
      .permit(:number, :total_value, :invoice_type, installments_attributes: [:id, :invoice_id, :_destroy, :number, :value, :due_date])
  end

  def operation_params
    params
      .require(:invoice)
      .permit(operation_attributes: [:status])
  end

  def payer_params
    params
      .require(:invoice)
      .permit(payer_attributes: [:company_name, :identification_number, :address, :address_number, :neighborhood, :city, :state, :zip_code, :registration_number])
  end

  def seller_params
    params
      .require(:invoice)
      .permit(operation_attributes: [seller_attributes: [:company_name, :identification_number]])
  end
end
