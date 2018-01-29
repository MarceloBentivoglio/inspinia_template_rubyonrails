class Operation < ApplicationRecord
  has_many :rebuys
  has_many :sellers_concentrations
  has_many :payers_concentrations
  has_many :sellers_limits
  has_many :payers_limits
  has_many :invoices
  belongs_to :seller
  accepts_nested_attributes_for :seller,
                                allow_destroy: true
  monetize :total_value_cents, :average_interest_cents, :average_ad_valorem_cents, :fee_instrucoes_bancarias_em_titulos_cents, :fee_aditivo_cents, :fee_cobranca_custodia_cheques_cents, :fee_cobranca_notificacao_duplicatas_cents, :fee_consulta_de_credito_cents, :fee_doc_ted_transferencia_cents, :tax_iss_cents, :tax_pis_cents, :tax_cofins_cents, :tax_retained_pis_cents, :tax_retained_cofins_cents, :tax_retained_irpj_cents, :tax_retained_csll_cents, :tax_retained_iof_cents, :advancement_cents, :tax_ratained_iof_adicional_cents, with_model_currency: :currency
end
