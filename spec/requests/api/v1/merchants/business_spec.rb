require 'rails_helper'

RSpec.describe 'Business Intelligence Endpoints' do
  describe 'Merchant Revnue Breakdowns on Paid Invoices' do
    before :each do
       @customer = create(:customer)
       @merchant1 = Merchant.create!(name: 'Rose Apothocary')
       @item1 = @merchant1.items.create( name: 'Face Cream', description: 'Beauty', unit_price: 12.01)
       @item2 = @merchant1.items.create( name: 'Oils', description: 'Relaxing', unit_price: 15.01)
       @invoice = @merchant.invoices.create(customer_id: @customer.id, status: 'shipped')
       @itm_inv = @item1.invoice_items.create!(invoice_id: @invoice.id, quantity: 4, unit_price: @item2.unit_price)
       @transaction = @invoice.transactions.create(credit_card_number: 237, credit_card_expiration_date: 12497600, result: 'success')
       @merchant2 = Merchant.create!(name: 'Sports Fan')
       @item4 = @merchant2.items.create( name: 'Basketball', description: 'orange and round', unit_price: 25.00)
       @item5 = @merchant2.items.create( name: 'Tennis Raquet', description: 'Smooth contact', unit_price: 18.01)
       @invoice2 = @merchant2.invoices.create(customer_id: @customer.id, status: 'shipped')
       @it_inv2 = @item5.invoice_items.create!(invoice_id: @invoice.id, quantity: 2, unit_price: @item5.unit_price)
       @transaction2 = @invoice2.transactions.create(credit_card_number: 864, credit_card_expiration_date: 12772092, result: 'success')
    end

    it "can get merchants with most revenue" do
      get '/api/v1/merchants/most_revenue?quantity=3'

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)
      merchants = json[:data]
    end

    it "can get merchants with most items sold" do

    end
  end
end
