require 'json'
require 'open-uri'

class ReceitawsApiCall
  def check_cnpj(cnpj)
    url = "https://www.receitaws.com.br/v1/cnpj/#{cnpj}"
    cnpj_report_serialized = open(url).read
    cnpj_report = JSON.parse(cnpj_report_serialized)
    return cnpj_report
  end
end
