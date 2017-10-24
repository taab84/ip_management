class OrdersController < ApplicationController
  protect_from_forgery with: :null_session
  def select_request
  	number = params[:number]
  	@orders = [PayementOrder.where(number: number)]
  	render json: @orders
  end
end
