class CnpjChecksController < ApplicationController
  def fetch_information
    cnpj = Seller.new(cnpj_params).identification_number
    cnpj_report = ReceitawsApiCall.new.check_cnpj(cnpj)
    create_company(cnpj_report)
  end

  def create_company(cnpj_report)
    @seller = Seller.new(
      identification_number: cnpj_report["cnpj"],
      company_name: cnpj_report["nome"],
      company_nickname: cnpj_report["fantasia"],
      business_entity: cnpj_report["natureza_juridica"],
      # registration_number: nil,
      # nire: ,
      incorporation_date: cnpj_report["abertura"],
      zip_code: cnpj_report["cep"],
      address: cnpj_report["logradouro"],
      address_number: cnpj_report["numero"],
      neighborhood: cnpj_report["bairro"],
      # address_2: ,
      state: cnpj_report["uf"] ,
      city: cnpj_report["municipio"],
      corporate_capital: cnpj_report["capital_social"],
      activity: cnpj_report["atividade_principal"],
      # cnae: ,
      # tax_option: ,
      )
      # redirect_to url_for(controller: :seller, action: :new)
      render 'sellers/new'
  end

  private

  def cnpj_params
    params.require(:seller).permit(:identification_number)
  end
end
