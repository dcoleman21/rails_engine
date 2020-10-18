class InvoiceItem < ApplicationRecord
  validates :quantity, presence: true
  validates :unit_price, presence: true

  has_many :items, dependent: :destroy
  has_mnay :items, through: :invoice_items
end
