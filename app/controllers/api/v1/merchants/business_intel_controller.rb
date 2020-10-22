class Api::V1::Merchants::BusinessIntelController < ApplicationController
  def most_revenue
    merchants = MerchantFacade.most_revenue(params[:quantity])
    render json: MerchantSerializer.new(merchants).serialized_json
  end
end
