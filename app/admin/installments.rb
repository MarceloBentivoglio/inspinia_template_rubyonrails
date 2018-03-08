ActiveAdmin.register Installment do

  index do
    selectable_column
    column :invoice
    column :number
    column :value_cents
    column :due_date
    column :created_at
    column :paid
    column :deposit_date
    actions
  end

end
