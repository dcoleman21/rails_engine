require 'rails_helper'

RSpec.describe 'Business Intelligence Endpoints' do
  describe 'Merchant Revnue Breakdowns on Paid Invoices' do
    before :each do
      @m1, @m2, @m3, @m4, @m5, @m6 = create_list(:merchant, 6)

      @it1 = create(:item, merchant: @m1)
      @it2 = create(:item, merchant: @m2)
      @it3 = create(:item, merchant: @m3)
      @it4 = create(:item, merchant: @m4)
      @it5 = create(:item, merchant: @m5)
      @it6 = create(:item, merchant: @m6)

      @iv1 = create(:invoice, merchant: @m1, status: 'shipped', created_at: '2020-01-01T00:00:00 UTC')
      @iv2 = create(:invoice, merchant: @m2, status: 'shipped', created_at: '2020-02-02T00:00:00 UTC')
      @iv3 = create(:invoice, merchant: @m3, status: 'shipped', created_at: '2020-03-03T00:00:00 UTC')
      @iv4 = create(:invoice, merchant: @m4, status: 'shipped', created_at: '2020-04-04T00:00:00 UTC')
      @iv5 = create(:invoice, merchant: @m5, status: 'shipped', created_at: '2020-05-05T00:00:00 UTC')
      @iv6 = create(:invoice, merchant: @m6, status: 'packaged', created_at: '2020-06-06T00:00:00 UTC')

      @ii1 = create(:invoice_item, invoice: @iv1, item: @it1, quantity: 10, unit_price: 1) # rev: $10
      @ii2 = create(:invoice_item, invoice: @iv2, item: @it2, quantity: 20, unit_price: 3) # rev: $60
      @ii3 = create(:invoice_item, invoice: @iv3, item: @it3, quantity: 30, unit_price: 5) # rev: $150
      @ii4 = create(:invoice_item, invoice: @iv4, item: @it4, quantity: 40, unit_price: 7) # rev: $280
      @ii5 = create(:invoice_item, invoice: @iv5, item: @it5, quantity: 50, unit_price: 9) # rev: $450
      @ii6 = create(:invoice_item, invoice: @iv6, item: @it6, quantity: 60, unit_price: 11) # rev: $660

      @t1 = create(:transaction, invoice: @iv1, result: 'success')
      @t2 = create(:transaction, invoice: @iv2, result: 'success')
      @t3 = create(:transaction, invoice: @iv3, result: 'success')
      @t4 = create(:transaction, invoice: @iv4, result: 'success')
      @t5 = create(:transaction, invoice: @iv5, result: 'success')
      @t6 = create(:transaction, invoice: @iv6, result: 'success')
    end

    it "can get merchants with most revenue" do
      get '/api/v1/merchants/most_revenue?quantity=6'

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)
      merchants = json[:data]

      expect(merchants).to be_an(Array)
      expect(merchants.length).to eq(5)

      expect(merchants[0]).to have_key(:id)
      expect(merchants[0][:id]).to be_a(String)

      expect(merchants[0]).to have_key(:attributes)
      expect(merchants[0]).to be_a(Hash)

      expect(merchants[0][:attributes]).to have_key(:name)
      expect(merchants[0][:attributes][:name]).to be_a(String)
      expect(merchants[0][:attributes][:name]).to eq(@m5.name)
      expect(merchants[1][:attributes][:name]).to eq(@m4.name)
      expect(merchants[2][:attributes][:name]).to eq(@m3.name)
      expect(merchants[3][:attributes][:name]).to eq(@m2.name)
      expect(merchants[4][:attributes][:name]).to eq(@m1.name)
    end

    it "can get merchants with most items sold" do

    end
  end
end
