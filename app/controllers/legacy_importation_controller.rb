class LegacyImportationController < ApplicationController
  def import_legacy_data(options = {user: current_user})
   # TODO: Check if the header is equal to the template header
   # TODO: refatorar esse codigo
    problem_line = []
    payers_workbook = Creek::Book.new 'lib/xlsx_reader/sacados.xlsx'
    payers_worksheets = payers_workbook.sheets
    payers_worksheets.each do |worksheet|
      worksheet.rows.each_with_index do |row, row_number|
        next if (0 .. 2).include? row_number
        cols = row.values
        puts "payer: #{row_number}"
        break if cols[0].nil?
        # TODO: Separate the address number from the address, maybe using regex
        payer_attributes = {
          company_name: cols[1],
          company_nickname: cols[1][0,15],
          identification_number: clean_company_identification_number(cols[2]),
          address: cols[3],
          zip_code: cols [4],
          city: cols[5],
          email: cols[6],
          phone_number: cols[7]
        }
        payer = Payer.new(payer_attributes)
        if payer.save!
        else
          puts "foi a linha #{row_number} de payer que deu problema"
          problem_line << row_number
        end

      end
    end
    puts "Payers imported with success"

    sellers_workbook = Creek::Book.new 'lib/xlsx_reader/cedentes.xlsx'
    sellers_worksheets = sellers_workbook.sheets
    sellers_worksheets.each do |worksheet|
      worksheet.rows.each_with_index do |row, row_number|
        next if (0 .. 2).include? row_number
        cols = row.values
        puts "seller: #{row_number}"
        break if cols[0].nil?
        # TODO: Separate the address number from the address, maybe using regex
        seller_attributes = {
          company_name: cols[0],
          company_nickname: cols[0][0,15],
          identification_number: clean_company_identification_number(cols[1]),
          address: cols[2],
          zip_code: cols [3],
          city: cols[4],
          email: cols[5],
          phone_number: cols[6],
          client: options[:user].client,
        }
        seller = Seller.new(seller_attributes)
        if seller.save!
        else
          puts "foi a linha #{row_number} de seller que deu problema"
          problem_line << row_number
        end
      end
    end
    puts 'Sellers imported with success!'

    if problem_line.empty?
      puts "\n\n\n não deu problema \n\n\n"
    else
      puts "Linhas com problemas:"
      problem_line.each do |line|
        puts line
      end
    end

    paid_operations_workbook = Creek::Book.new 'lib/xlsx_reader/operacoes_liquidadas.xlsx'
    paid_operations_worksheets = paid_operations_workbook.sheets
    extract_operations_invoices_installments(paid_operations_worksheets, true)

    pending_payment_operations_workbook = Creek::Book.new 'lib/xlsx_reader/operacoes_em_aberto.xlsx'
    pending_payment_operations_worksheets = pending_payment_operations_workbook.sheets
    extract_operations_invoices_installments(pending_payment_operations_worksheets, false)

  rescue
    redirect_to root_path
  end

  def extract_operations_invoices_installments(operations_worksheets, paid_flag)
    problem_line = []
    operations_worksheets.each do |worksheet|
      worksheet.rows.each_with_index do |row, row_number|
        next if (0 .. 3).include? row_number
        cols = row.values
        puts "operation: #{row_number}"
        break if cols[0].nil?
        # Right now we don't want operations that has rebuys, créditos ou pendencias
        next unless [cols[13], cols[15], cols[16], cols[18]].all? {|col| col == "0" || col.nil?}
        # This line can be used in case where the xlsx file does not carry the seller's identification number
        # seller: Seller.where("company_name LIKE '#{cols[3]}%'").first,
        if cols[0] == cols[1]
          operation_attributes = {
            status: paid_flag ? Invoice::INVOICES_STATUS[4] : Invoice::INVOICES_STATUS[5],
            importation_reference: cols[1],
            deposit_date: DateTime.parse(cols[2]),
            seller: Seller.find_by_identification_number(clean_company_identification_number(cols[4])),
            total_value: Money.new(treat_currency_from_file(cols[5])),
            average_interest: Money.new(treat_currency_from_file(cols[6])),
            average_ad_valorem: Money.new(treat_currency_from_file(cols[8])),
            average_outstanding_days: treat_float_from_file(cols[10]),
            fee_doc_ted_transferencia: Money.new(treat_currency_from_file(cols[11])),
            tax_retained_iof_adicional: Money.new(treat_currency_from_file(cols[12])),
            advancement: Money.new(treat_currency_from_file(cols[17]))
          }
          operation = Operation.new(operation_attributes)
          if operation.save!
          else
            puts "foi a linha #{row_number} de operation que deu problema"
            problem_line << row_number
          end

        else
          if Operation.where("importation_reference = ?", cols[0]).exists?
            installment_attributes = {
              status: paid_flag ? Invoice::INVOICES_STATUS[4] : Invoice::INVOICES_STATUS[5],
              importation_reference: cols[0],
              number: cols[5],
              interest: Money.new(treat_currency_from_file(cols[7])),
              ad_valorem: Money.new(treat_currency_from_file(cols[9])),
              due_date: DateTime.parse(cols[11]),
              value: Money.new(treat_currency_from_file(cols[12]))
            }
            # TODO: Fazer funcionar para vários clients pq só funciona isso se tiver apenas um client
            if Invoice.where("number = ? AND importation_reference = ?", installment_attributes[:number].slice(0..-2), installment_attributes[:importation_reference]).exists?
              installment_attributes[:invoice] = Invoice.where("number = ? AND importation_reference = ?", installment_attributes[:number].slice(0..-2), installment_attributes[:importation_reference]).first
            else
              invoice_attributes = {
                status: paid_flag ? Invoice::INVOICES_STATUS[4] : Invoice::INVOICES_STATUS[5],
                importation_reference: cols[0],
                invoice_type: find_invoice_type(cols[2]),
                payer: Payer.find_by_identification_number(clean_company_identification_number(cols[4])),
                number: cols[5].slice(0..-2),
                operation: Operation.find_by_importation_reference(cols[0]),
              }
              invoice = Invoice.new(invoice_attributes)
              if invoice.save!
              else
                puts "foi a linha #{row_number} de invoice que deu problema"
                problem_line << row_number
              end
              installment_attributes[:invoice] = invoice
            end
            installment = Installment.new(installment_attributes)
            if installment.save!
            else
              puts "foi a linha #{row_number} de invoice que deu problema"
              problem_line << row_number
            end

          end
        end
      end
      puts "Operations imported with success!"
    end

    if problem_line.empty?
      puts "\n\n\n não deu problema \n\n\n"
    else
      puts "Linhas com problemas:"
      problem_line.each do |line|
        puts line
      end
    end

    Invoice.all.each do |invoice|
      invoice.total_value = invoice.installments.reduce(Money.new(0)) {|total_value, installment| total_value + installment.value}
      if invoice.save!
        puts "valor da invoice #{invoice.id} calculado com sucesso!"
      else
        puts "invoice que deu problema #{invoice.id}"
      end
    end
  end

  def clean_company_identification_number(cnpj)
    cnpj.delete! './-'
    return cnpj
  end

  def treat_currency_from_file(string)
    string = sprintf('%.2f', string)
    string.delete! '.'
  end

  def treat_float_from_file(string)
    string
  end

  def find_invoice_type(string)
    case string
      when "CHQ"
        Invoice::INVOICES_TYPE[0]
      when "DMR"
        Invoice::INVOICES_TYPE[1]
      else
        Invoice::INVOICES_TYPE[2]
    end
  end
end
