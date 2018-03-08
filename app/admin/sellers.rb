ActiveAdmin.register Seller do

  index do
    selectable_column
    column :client
    column :identification_number
    column :company_nickname
    column :limit
    column :address
    column :zip_code
    column :city
    column :email
    column :phone_number
    actions
  end
end
