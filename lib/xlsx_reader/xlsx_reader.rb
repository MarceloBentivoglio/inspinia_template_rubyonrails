require 'creek'
require 'pry-byebug'

workbook = Creek::Book.new 'lib/xlsx_reader/relatorio_operacao_completo_copy.xlsx'
worksheets = workbook.sheets
# puts "Found #{worksheets.count} worksheets"

# TODO: Check if the header is equal to the template header

#
worksheets.each do |worksheet|
  # puts "Reading: #{worksheet.name}"
  # row_number = 0

  worksheet.rows.each_with_index do |row, row_number|
    cols = row.values
    next if (0 .. 3).include? row_number
    # Right now we don't want operations that has rebuys, créditos ou pendencias
    next unless [cols[12], cols[14], cols[15], cols[17]].include? 0

    # p row_cols = row.values
    # p row_number

    # For records that are operations
    # Invoices don't have the operation ID on the first column of excel
    binding.pry
    if cols[0] == cols[1]
      attributes = {
        importation_reference: cols[0],
        deposit_date: DateTime.parse(cols[2]),
        seller: Seller.find_by_company_name(cols(3)),
        total_value: cols[4],
        average_interest: cols[5],
        average_ad_valorem: cols[7],
        average_outstanding_days: cols[9],
        fee_doc_ted_transferencia: cols[10],
        tax_retained_iof_adicional: cols[11],
        advancement: cols[16]
      }


      # row_cells.each_with_index do |cell, column|
      #   next if (0).include? column
      #   attributes[:importation_reference] = cell if column == 1
      # end

      operation = Operation.new(attributes)
      binding.pry
    end
  end

end

