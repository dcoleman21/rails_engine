class InvoiceItem < ApplicationRecord
  validates :quantity, presence: true
  validates :unit_price, presence: true

  has_many :items
  has_many :items, through: :invoice_items
end
