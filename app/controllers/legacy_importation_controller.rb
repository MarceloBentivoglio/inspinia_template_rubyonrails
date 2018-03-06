class LegacyImportationController < ApplicationController
  def import_legacy_data(options = {user: current_user})
   # TODO: Check if the header is equal to the template header
   # TODO: refatorar esse codigo
    problem_line = []
    payers_workbook = Creek::Book.new 'lib/xlsx_reader/sacados_biort.xlsx'
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
        next if !(cols[0].include? "BIORT")
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

  rescue
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

  def define_invoice_type(invoice, invoice_type)
    case invoice_type
      when "CHQ"
        invoice.check!
      when "DMR"
        invoice.traditional_invoice!
      else
        invoice.contract!
    end
  end
end
