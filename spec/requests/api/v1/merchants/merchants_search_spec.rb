require 'rails_helper'

describe "Merchant Search Endpoints" do
  it "can find a list of merchants that contain a fragment, case insensitive" do
    create(:merchant, name: "Basketball")
    create(:merchant, name: "Baseball")
    create(:merchant, name: "Volleyball")
    create(:merchant, name: "Helmet")

    get '/api/v1/merchants/find_all?name=BALL'

    expect(response).to be_successful

    merchants_containing_ball = JSON.parse(response.body, symbolize_names: true)
    expect(merchants_containing_ball).to be_a Hash

    search_results = merchants_containing_ball[:data]
    expect(search_results).to be_a Array
    expect(search_results.count).to eq(3)
    expect(search_results[0][:attributes][:name].downcase.include?("ball")).to eq(true)
    expect(search_results[1][:attributes][:name].downcase.include?("ball")).to eq(true)
    expect(search_results[2][:attributes][:name].downcase.include?("ball")).to eq(true)
  end

  it "can find a merchant that contains a fragment, case insensitive" do
    create(:merchant, name: "Basketball")
    create(:merchant, name: "Baseball")
    create(:merchant, name: "Volleyball")
    create(:merchant, name: "Helmet")

    get '/api/v1/merchants/find?name=BALL'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to be_a Hash

    merchant = json[:data]
    expect(merchant).to be_a Hash
    expect(merchant[:attributes][:name].downcase.include?("ball")).to eq(true)
  end
end
