class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  load_and_authorize_resource

  def list
  	number = params[:number]
    @orders = [Order.where('number = ? AND remain > 0', number)]
    if @orders.count > 0 then
      render json: @orders
    else
      render json: Order.last(3)
    end
  end

  def new
    @order = order_type.new
  end

  def create
    @order = Order.new(order_params)
    # respond_to do |format|
      if @order.save
        render json:@order
        # format.json { render @order }
      else
        render json: {errors: @order.errors.full_messages}
        # format.json { render json: @order.errors }
      end
    # end
  end

  def show
    render json:@order
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:image, :type, payement_attributes:[:type, :value, :name, :date, :image, :serie, :number, :ref, :state, :_destroy])
  end

end
