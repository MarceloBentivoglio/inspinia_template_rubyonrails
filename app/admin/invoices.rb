ActiveAdmin.register Invoice do
  permit_params [ :id,
  :number,
  :confirmed,
  :notified,
  :boleto_especial,
  :total_value_cents,
  :payer_id,
  :invoice_type,
  :delivery_status,
  :backoffice_status,
  :sale_status,
  :buyer_id ]

  index do
    selectable_column
    column :confirmed
    column :notified
    column :boleto_especial
    column :total_value_cents
    column :created_at
    column :payer
    column :number
    column :order
    column :buyer
    column :invoice_type
    column :delivery_status
    column :backoffice_status
    column :sale_status
    actions
  end
end
