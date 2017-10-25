class OrdersController < ApplicationController
  protect_from_forgery with: :null_session
  def select_request
  	number = params[:number]
  	@orders = [PayementOrder.where(number: number)]
  	render json: @orders
  end
  def create
  end

  def show
  end

  private

  def order_params
    params.require(:payement_order).permit(:id, :image, :number, payement_attributes:[:id, :type, :value, :name, :date, :image, :serie, :number, :ref, :state, :_destroy])
  end

end
