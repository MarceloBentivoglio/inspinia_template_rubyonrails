ActiveAdmin.register Payer do

  index do
    selectable_column
    column :identification_number
    column :company_nickname
    column :address
    column :zip_code
    column :city
    column :email
    column :phone_number
    actions
  end
end
