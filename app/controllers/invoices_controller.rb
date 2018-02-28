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

    @installments_paid_amount = Money.new(@seller.operations.joins(invoices: :installments).where(invoices: {installments: {paid: true}}).sum("value_cents"))
    @installments_paid_quantity = @seller.operations.joins(invoices: :installments).where(invoices: {installments: {paid: true}}).count
    @installments_paid = @seller.operations.joins(invoices: :installments).where(invoices: {installments: {paid: true}}).group_by_month(:deposit_date, last: 8, format: "%b %y").sum("value_cents")
    @installments_paid.transform_values! {|monthly_amount| monthly_amount.to_f/100}

    time_range_future = Time.now..(Time.now + 1.year)
    @installments_on_date_amount = Money.new(@seller.operations.joins(invoices: :installments).where(invoices: {installments: {paid: false, due_date: time_range_future}}).sum("value_cents"))
    @installments_on_date_quantity = @seller.operations.joins(invoices: :installments).where(invoices: {installments: {paid: false, due_date: time_range_future}}).count
    @installments_on_date = @seller.operations.joins(invoices: :installments).where(invoices: {installments: {paid: false, due_date: time_range_future}}).group_by_month(:deposit_date, last: 8, format: "%b %y").sum("value_cents")
    @installments_on_date.transform_values! {|monthly_amount| monthly_amount.to_f/100}

    time_range_past = (Time.now - 6.years)...(Time.now)
    @installments_overdue_amount = Money.new(@seller.operations.joins(invoices: :installments).where(invoices: {installments: {paid: false, due_date: time_range_past}}).sum("value_cents"))
    @installments_overdue_quantity = @seller.operations.joins(invoices: :installments).where(invoices: {installments: {paid: false, due_date: time_range_past}}).count
    @installments_overdue = @seller.operations.joins(invoices: :installments).where(invoices: {installments: {paid: false, due_date: time_range_past}}).group_by_month(:deposit_date, last: 8, format: "%b %y").sum("value_cents")
    @installments_overdue.transform_values! {|monthly_amount| monthly_amount.to_f/100}

    @installments_all_keys = @installments_overdue.merge(@installments_on_date.merge(@installments_paid))
    @installments_all_keys = @installments_all_keys.sort_by {|date, value| Date.strptime(date, "%b %y") }.to_h
    @installments_paid = merge_smaller_hash_into_bigger(@installments_paid, @installments_all_keys)
    @installments_on_date = merge_smaller_hash_into_bigger(@installments_on_date, @installments_all_keys)
    @installments_overdue = merge_smaller_hash_into_bigger(@installments_overdue, @installments_all_keys)

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
    invoice.seller = seller
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

  def rejection
    @invoices = Invoice.find(JSON.parse(params[:invoices_ids]))
  end

  def payment_status

  end

  private

  def merge_smaller_hash_into_bigger(small, big)
    new_hash = {}
    big.each do |key, value|
      new_hash[key] = small[key] ? small[key] : 0
    end
    return new_hash
  end

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
