class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  load_and_authorize_resource

  def select_request
  	number = params[:number]
  	@orders = [PayementOrder.where(number: number)]
  	render json: @orders
  end

  def new
    @order = order_type.new
  end

  def create
    @order = PayementOrder.new(order_params)
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
    @order = PayementOrder.find(params[:id])
  end

  def order_params
    params.require(:payement_order).permit(:image, payement_attributes:[:type, :value, :name, :date, :image, :serie, :number, :ref, :state, :_destroy])
  end

end
