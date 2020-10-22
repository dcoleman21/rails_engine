class Api::V1::Merchants::BusinessIntelController < ApplicationController
  def most_revenue
    merchants = MerchantFacade.most_revenue(params[:quantity])
    render json: MerchantSerializer.new(merchants).serialized_json
  end

  def most_items
    merchants = MerchantFacade.most_items_sold(params[:quantity])
    render json: MerchantSerializer.new(merchants).serialized_json
  end

  def merchant_revenue
    merchant = MerchantFacade.revenue(params[:id])
    render json: RevenueSerializer.new(merchant).serialized_json
  end
end
