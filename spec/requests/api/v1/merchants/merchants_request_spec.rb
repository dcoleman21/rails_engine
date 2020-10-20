require 'rails_helper'

describe "Merchants API" do
  it 'can get one merchant by its id' do
    id = create(:merchant).id
    get "/api/v1/merchants/#{id}"
    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)
    merchant = json[:data]
    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_an(String)
    expect(merchant).to have_key(:type)
    expect(merchant[:type]).to be_an(String)
    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes]).to be_a(Hash)
    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_an(String)
  end

  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    merchants = json[:data]

    expect(merchants).to be_an(Array)
    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      # require "pry"; binding.pry
      expect(merchant[:id]).to be_an(String)

      expect(merchant).to have_key(:type)
      expect(merchant[:type]).to be_an(String)

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes]).to be_a(Hash)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it 'can create a new merchant' do
    merchant_params = ({name: 'Aris Apothecary'})
    headers = {"CONTENT_TYPE" => "application/json"}
    post "/api/v1/merchants", headers: headers, params: JSON.generate(merchant_params)
    new_merchant = Merchant.last
    expect(response).to be_successful
    expect(new_merchant.name).to eq(merchant_params[:name])
  end

  it 'can destroy a merchant' do
    merchant = create(:merchant)
    expect{ delete "/api/v1/merchants/#{merchant.id}" }.to change(Merchant, :count).by(-1)
    expect(response).to be_successful
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'can update an existing merchant' do
    id = create(:merchant).id
    previous_name = Merchant.last.name
    merchant_params = { name: "Smokeys Place" }
    headers = {"CONTENT_TYPE" => "application/json"}
    patch "/api/v1/merchants/#{id}", headers: headers, params: JSON.generate(merchant_params)
    merchant = Merchant.find(id)
    expect(response).to be_successful
    expect(merchant.name).to_not eq(previous_name)
    expect(merchant.name).to eq(merchant_params[:name])
  end
end
