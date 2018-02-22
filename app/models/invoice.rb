class Invoice < ApplicationRecord
  # enum status: {
  #   check: 0,
  #   invoice: 1,
  # }

  # invoice.status == :check
  # invoice.check?

  # invoice.update!(status: :check)
  # invoice.check!

  # Invoice.where(status: 0)
  # Invoice.where(status: :check)
  # Invoice.check

  INVOICES_TYPE = ["check", "invoice", "contract"]
  INVOICES_STATUS = ["waiting_for_deposit", "on_date", "at_due_date", "pending_payment", "paid", "not_paid"]
  belongs_to :operation, optional: true
  belongs_to :payer, optional: true
  delegate :seller, to: :operation, allow_nil: true
  has_one :offer
  has_one :purchase
  belongs_to :order, optional: true
  has_many :rebuys
  has_many :installments, dependent: :destroy
  # We need this line so that we can create invoice forms with installments (reference: https://www.youtube.com/watch?v=pulzZxPkgmE)
  accepts_nested_attributes_for :installments,
                                allow_destroy: true
                                # reject_if: :all_blank
  accepts_nested_attributes_for :payer,
                                allow_destroy: true
  accepts_nested_attributes_for :operation,
                                allow_destroy: true

  # We need this to upload the invoices in xml format
  has_attached_file :xml_file

  # We need this so that the program understands that total_value is a Money object
  monetize :total_value_cents, :average_interest_cents, :average_ad_valorem_cents, with_model_currency: :currency


  def self.from_file(file)
    doc = Nokogiri::XML(file.read)
    file.rewind
    invoice = Invoice.new
    invoice = extract_invoice_general_info(doc, invoice)
    invoice = extract_installments(doc, invoice)
    invoice = extract_payer_info(doc, invoice)
    invoice.operation = Operation.new(status: "waiting_for_deposit")
    extract_seller_info(doc, invoice)
    return invoice
  end

  private

  def self.extract_invoice_general_info (doc, invoice)
    invoice.number = doc.search('fat nFat').text.strip
    # delete("\n .")): takes out blanks spaces, points and paragraphs, otherwise Money class will read "1000.00" as 1000 and convert to 10.00
    invoice.total_value = Money.new(doc.search('fat vLiq').text.delete("\n ."))
    return invoice
  end

  def self.extract_installments (doc, invoice)
    doc.search('dup').each do |xml_installments_info|
      i = Installment.new
      i.number = xml_installments_info.search('nDup').text.strip
      # delete("\n .")): takes out blanks spaces, points and paragraphs, otherwise Money class will read "1000.00" as 1000 and convert to 10.00
      i.value = Money.new(xml_installments_info.search('vDup').text.delete("\n ."))
      i.due_date = xml_installments_info.search('dVenc').text.strip
      i.invoice = invoice
      invoice.installments.push(i)
    end
    return invoice
  end

  #TODO: split this method it is too big
  def self.extract_payer_info (doc, invoice)
    doc.search('dest').each do |xml_payer_info|
      identification_number = xml_payer_info.search('CNPJ').text.strip
      if Payer.exists?(identification_number: identification_number)
        payer = Payer.find_by_identification_number(identification_number)
      else
        payer = Payer.new
        payer.identification_number = identification_number
        payer.company_name = xml_payer_info.search('xNome').text.strip
        payer.address = xml_payer_info.search('xLgr').text.strip
        payer.address_number = xml_payer_info.search('nro').text.strip
        payer.neighborhood = xml_payer_info.search('xBairro').text.strip
        payer.city = xml_payer_info.search('xMun').text.strip
        payer.state = xml_payer_info.search('UF').text.strip
        payer.zip_code = xml_payer_info.search('CEP').text.strip
        payer.registration_number = xml_payer_info.search('IE').text.strip
      end
      invoice.payer = payer
      return invoice
    end
  end

  def self.extract_seller_info (doc, invoice)
    doc.search('emit').each do |xml_seller_info|
      identification_number = xml_seller_info.search('CNPJ').text.strip
      if Seller.exists?(identification_number: identification_number)
        seller = Seller.find_by_identification_number(identification_number)
      else
        seller = Seller.new
        seller.identification_number = identification_number
        seller.company_name = xml_seller_info.search('xNome').text.strip
        seller.company_nickname = xml_seller_info.search('xFant').text.strip
      end
      invoice.operation.seller = seller
    end
  end

  def taxes
    (total_value * 0.2).cents
  end
end
