class Purchase < ApplicationRecord
  belongs_to :buyer, class_name: 'Client'
  belongs_to :invoice
end
