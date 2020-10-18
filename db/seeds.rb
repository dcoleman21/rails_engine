# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Transaction.destroy_all
# InvoiceItem.destroy_all
Invoice.destroy_all
Item.destroy_all
Merchant.destroy_all
Customer.destroy_all

require "csv"

  CSV.foreach(Rails.root.join('db/data/customers.csv'), headers: true) do |row|
    Customer.create(row.to_h)
  end

  CSV.foreach(Rails.root.join('db/data/merchants.csv'), headers: true) do |row|
    Merchant.create(row.to_h)
  end

  CSV.foreach(Rails.root.join('db/data/items.csv'), headers: true) do |row|
    row["unit_price"] = (row["unit_price"].to_f / 100).round(2)
    Item.create(row.to_h)
  end

  CSV.foreach(Rails.root.join('db/data/invoices.csv'), headers: true) do |row|
    Invoice.create(row.to_h)
  end
  # NEED HELP ON THIS ^^^^
  # CSV.foreach(Rails.root.join('db/data/invoice_items.csv'), headers: true) do |row|
  #   row[:unit_price] = row[:unit_price] / 100.0
  #   InvoiceItem.create(row)
  # end
  #
  # CSV.foreach(Rails.root.join('db/data/transactions.csv'), headers: true) do |row|
  #   Transaction.create(row)
  # end

  # reset primary key sequence postgres for all
