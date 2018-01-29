class AddColumnsToOperation < ActiveRecord::Migration[5.1]
  def change
    add_monetize :operations, :average_interest
    add_monetize :operations, :average_ad_valorem
    add_column :operations, :average_outstanding_days, :integer
    add_monetize :operations, :fee_instrucoes_bancarias_em_titulos
    add_monetize :operations, :fee_aditivo
    add_monetize :operations, :fee_cobranca_custodia_cheques
    add_monetize :operations, :fee_consulta_de_credito
    add_monetize :operations, :fee_cobranca_notificacao_duplicatas
    add_monetize :operations, :fee_doc_ted_transferencia
    add_monetize :operations, :tax_iss
    add_monetize :operations, :tax_pis
    add_monetize :operations, :tax_cofins
    add_monetize :operations, :tax_retained_pis
    add_monetize :operations, :tax_retained_cofins
    add_monetize :operations, :tax_retained_irpj
    add_monetize :operations, :tax_retained_csll
    add_monetize :operations, :tax_retained_iof
    add_monetize :operations, :advancement
    add_monetize :operations, :tax_ratained_iof_adicional
    add_column :operations, :approval_date, :datetime
    add_column :operations, :closure_date, :datetime
    add_column :operations, :status, :string
    add_reference :operations, :seller, foreign_key: true
  end
end
