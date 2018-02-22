class Order < ApplicationRecord
  belongs_to :buyer, class_name: "Client"
  has_many :invoices
  validates_presence_of :invoices
end
