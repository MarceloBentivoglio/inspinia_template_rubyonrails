require 'creek'
require 'pry-byebug'
require 'payer'

  def clean_company_identification_number(cnpj)
    cnpj.delete! './-'
  end

  def treat_currency_from_file(string)
    string.delete! '.'
    string.gsub!(',','.')
    string = sprintf('%.2f', string)
    string.delete! '.'
  end

  def treat_float_from_file(string)
    string.gsub!(',','.')
  end

  def find_invoice_type(string)
    case string
      when "CHQ"
        INVOICES_TYPE[0]
      when "DMR"
        INVOICES_TYPE[1]
      else
        INVOICES_TYPE[2]
    end
  end

  puts "etapa 1"
  binding.pry
  payers_workbook = Creek::Book.new 'lib/xlsx_reader/CadastroSacados.xlsx'
  payers_worksheets = payers_workbook.sheets
  payers_worksheets.each do |worksheet|
    worksheet.rows.each_with_index do |row, row_number|
      next if (0 .. 2).include? row_number
      cols = row.values
      # TODO: Separate the address number from the address, maybe using regex
      payer_attributes = {
        company_name: cols[1],
        identification_number: clean_company_identification_number(cols[2]),
        address: cols[3],
        zip_code: cols [4],
        city: cols[5],
        email: cols[6],
        phone_number: cols[7]
      }
      Payer.new(payer_attributes).save!
    end
  end

  binding.pry
  sellers_workbook = Creek::Book.new 'lib/xlsx_reader/CadastroCedentes.xlsx'
  sellers_worksheets = sellers_workbook.sheets
  sellers_worksheets.each do |worksheet|
    worksheet.rows.each_with_index do |row, row_number|
      next if (0 .. 2).include? row_number
      cols = row.values
      # TODO: Separate the address number from the address, maybe using regex
      seller_attributes = {
        company_name: cols[0],
        identification_number: clean_company_identification_number(cols[1]),
        address: cols[2],
        zip_code: cols [3],
        city: cols[4],
        email: cols[5],
        phone_number: cols[6]
      }
      Seller.new(seller_attributes).save!
    end
  end
  binding.pry

  operations_workbook = Creek::Book.new 'lib/xlsx_reader/relatorio_operacao_completo_copy.xlsx'
  operations_worksheets = operations_workbook.sheets
  # TODO: Check if the header is equal to the template header
  operations_worksheets.each do |worksheet|
    # puts "Reading: #{worksheet.name}"
    # row_number = 0
    worksheet.rows.each_with_index do |row, row_number|
      next if (0 .. 3).include? row_number
      cols = row.values
      # Right now we don't want operations that has rebuys, créditos ou pendencias
      # TODO all have to be equal zero
      next unless [cols[12], cols[14], cols[15], cols[17]].all? {|col| col == 0}

      # p row_cols = row.values
      # p row_number

      # For records that are operations
      # Invoices don't have the operation ID on the first column of excel
      if cols[0] == cols[1]
        operation_attributes = {
          importation_reference: cols[0],
          deposit_date: DateTime.parse(cols[2]),
          seller: Seller.find_by_company_name(cols(3)),
          total_value: Money.new(treat_currency_from_file(cols[4])),
          average_interest: Money.new(treat_currency_from_file(cols[5])),
          average_ad_valorem: Money.new(treat_currency_from_file(cols[7])),
          average_outstanding_days: treat_float_from_file(cols[9]),
          fee_doc_ted_transferencia: Money.new(treat_currency_from_file(cols[10])),
          tax_retained_iof_adicional: Money.new(treat_currency_from_file(cols[11])),
          advancement: Money.new(treat_currency_from_file(cols[16]))
        }
        # row_cells.each_with_index do |cell, column|
        #   next if (0).include? column
        #   attributes[:importation_reference] = cell if column == 1
        # end
        Operation.new(operation_attributes).save!
        # For records that are installments
      else
        installment_attributes = {
          importation_reference: cols[0],
          number: cols[4],
          interest: Money.new(treat_currency_from_file(cols[5])),
          ad_valorem: Money.new(treat_currency_from_file(cols[7])),
          due_date: DateTime.parse(cols[9]),
          value: Money.new(treat_currency_from_file(cols[10]))
        }
        # TODO: Fazer funcionar para vários clients pq só funciona isso se tiver apenas um client
        # TODO: levar em consideração o id da operação
        if Invoice.where("number = ? AND importation_reference = ?", installment_attributes[:number].slice(0..-2), installment_attributes[:importation_reference]).exists?
          installment_attributes[invoice: Invoice.where("number = ? AND importation_reference = ?", installment_attributes[:number].slice(0..-2), installment_attributes[:importation_reference]).first]
        else
          # Here I take only the last character, but maybe I should take 2, in case we have more than 9 installments
          invoice_attributes = {
            importation_reference: cols[0],
            invoice_type: find_invoice_type(cols[2]),
            payer: Payer.find_by_company_name(cols(3)),
            number: cols[4].slice(0..-2)
          }
          invoice = Invoice.new(invoice_attributes)
          invoice.save!
          installment_attributes[invoice: invoice]
        end
        Installment.new(installment_attributes).save!
        binding.pry
      end
    end
  end


