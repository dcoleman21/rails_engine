class MerchantFacade
  def self.most_revenue(quantity)
    Merchant.joins(invoices: [:transactions, :invoice_items])
      .select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as most_revenue")
      .where("invoices.status='shipped' AND transactions.result='success'")
      .group("merchants.id")
      .order("most_revenue DESC")
      .limit(quantity)
  end

  def self.most_items_sold(quantity)
    Merchant.joins(invoices: [:transactions, :invoice_items])
      .select("merchants.*, sum(quantity) as most_items_sold")
      .where("invoices.status='shipped' AND transactions.result='success'")
      .group("merchants.id")
      .order("most_items_sold DESC")
      .limit(quantity)
  end

  # def self.revenue(_id)
  #   Merchant.joins(:transactions, :invoice_items)
  #   .select("sum(invoice_items.quantity * invoice_items.unit_price) as total")
  #   .where("invoices.status='shipped' AND transactions.result='success'")
  #   # .sum("('invoice_items.quantity * invoice_items.unit_price') as total")
  # end
end
