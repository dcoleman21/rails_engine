require 'rails_helper'

describe "Item search" do
  it "can find a list of items that contain a fragment, case insensitive" do
    create(:item, name: "Basketball")
    create(:item, name: "Baseball")
    create(:item, name: "Volleyball")
    create(:item, name: "Helmet")

    get '/api/v1/items/find_all?name=BALL'

    expect(response).to be_successful

    items_containing_ball = JSON.parse(response.body, symbolize_names: true)
    expect(items_containing_ball).to be_a Hash

    search_results = items_containing_ball[:data]
    expect(search_results).to be_a Array
    expect(search_results.count).to eq(3)
    expect(search_results[0][:attributes][:name].downcase.include?("ball")).to eq(true)
    expect(search_results[1][:attributes][:name].downcase.include?("ball")).to eq(true)
    expect(search_results[2][:attributes][:name].downcase.include?("ball")).to eq(true)
  end

  it "can find an item that contains a fragment, case insensitive" do
    create(:item, name: "Basketball")
    create(:item, name: "Baseball")
    create(:item, name: "Volleyball")
    create(:item, name: "Helmet")

    get '/api/v1/items/find?name=BALL'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to be_a Hash

    item = json[:data]
    expect(item).to be_a Hash
    expect(item[:attributes][:name].downcase.include?("ball")).to eq(true)
  end
end
