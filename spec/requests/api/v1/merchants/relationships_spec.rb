require 'rails_helper'

RSpec.describe 'MERCHANT ITEMS API' do
  it 'returns all items for that merchant' do
    var_1 = create(:merchant).id
    var_2 = create(:merchant).id
    create(:item, merchant_id: var_1)
    create(:item, merchant_id: var_1)
    create(:item, merchant_id: var_1)
    create(:item, merchant_id: var_2)
    create(:item, merchant_id: var_2)
    create(:item, merchant_id: var_2)
    get "/api/v1/merchants/#{var_1}/items"
    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)
    items = json[:data]
    expect(items).to be_an(Array)
    expect(items.count).to eq(3)
  end
end
