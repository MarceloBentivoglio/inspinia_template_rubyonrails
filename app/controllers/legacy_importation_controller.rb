class LegacyImportationController < ApplicationController
  def import
   # TODO: Check if the header is equal to the template header
   # TODO: refatorar esse codigo
    problem_line = []
    payers_workbook = Creek::Book.new 'lib/xlsx_reader/CadastroSacados.xlsx'
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

    sellers_workbook = Creek::Book.new 'lib/xlsx_reader/CadastroCedentes.xlsx'
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
          identification_number: clean_company_identification_number(cols[1]),
          address: cols[2],
          zip_code: cols [3],
          city: cols[4],
          email: cols[5],
          phone_number: cols[6],
          client: current_user.client,
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

    operations_workbook = Creek::Book.new 'lib/xlsx_reader/operacoes2.xlsx'
    operations_worksheets = operations_workbook.sheets
    operations_worksheets.each do |worksheet|
      worksheet.rows.each_with_index do |row, row_number|
        next if (0 .. 3).include? row_number
        cols = row.values
        puts "operation: #{row_number}"
        break if cols[0].nil?
        # Right now we don't want operations that has rebuys, créditos ou pendencias
        next unless [cols[12], cols[14], cols[15], cols[17]].all? {|col| col == "0" || col.nil?}
        if cols[0] == cols[1]
          operation_attributes = {
            importation_reference: cols[0],
            deposit_date: DateTime.parse(cols[2]),
            seller: Seller.find_by_company_name(cols[3]),
            seller: Seller.where("company_name LIKE '#{cols[3]}%'").first,
            total_value: Money.new(treat_currency_from_file(cols[4])),
            average_interest: Money.new(treat_currency_from_file(cols[5])),
            average_ad_valorem: Money.new(treat_currency_from_file(cols[7])),
            average_outstanding_days: treat_float_from_file(cols[9]),
            fee_doc_ted_transferencia: Money.new(treat_currency_from_file(cols[10])),
            tax_retained_iof_adicional: Money.new(treat_currency_from_file(cols[11])),
            advancement: Money.new(treat_currency_from_file(cols[16]))
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
              importation_reference: cols[0],
              number: cols[4],
              interest: Money.new(treat_currency_from_file(cols[5])),
              ad_valorem: Money.new(treat_currency_from_file(cols[7])),
              due_date: DateTime.parse(cols[9]),
              value: Money.new(treat_currency_from_file(cols[10]))
            }
            # TODO: Fazer funcionar para vários clients pq só funciona isso se tiver apenas um client
            if Invoice.where("number = ? AND importation_reference = ?", installment_attributes[:number].slice(0..-2), installment_attributes[:importation_reference]).exists?
              installment_attributes[:invoice] = Invoice.where("number = ? AND importation_reference = ?", installment_attributes[:number].slice(0..-2), installment_attributes[:importation_reference]).first
            else
              invoice_attributes = {
                importation_reference: cols[0],
                invoice_type: find_invoice_type(cols[2]),
                payer: Payer.find_by_company_name(cols[3]),
                number: cols[4].slice(0..-2),
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
        puts "valor de invoices computadas com sucesso!"
      else
        puts "invoice que deu problema #{invoice.id}"
      end
    end

    redirect_to root_path
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
