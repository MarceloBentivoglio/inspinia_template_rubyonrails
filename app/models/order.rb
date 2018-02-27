class Order < ApplicationRecord
  belongs_to :buyer, class_name: "Client"
  has_many :invoices
  has_many :installments, through: :invoices
  validates_presence_of :invoices
end
