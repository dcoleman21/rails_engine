class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
end

def self.most_revenue(quantity)
  joins(:transactions).select("items.id, items.name, sum(invoice_items.unit_price * invoice_items.quantity) as revenue").where("invoices.status='shipped' AND transactions.result='success'").group("merchant.id").order("revenue DESC").limit(quantity)
end
