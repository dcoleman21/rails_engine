class Api::V1::RevenueController < ApplicationController
  def date_range
    revenue = RevenueFacade.date_range(time_params)
    render json: RevenueSerializer.new(revenue)
  end

  private

  def time_params
    params.permit(:start, :end)
  end
end
