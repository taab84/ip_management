class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  load_and_authorize_resource

  def list
  	name = params[:name]
    @orders = Order.joins(:payement).where('payements.name ILIKE ? AND remain > 0', "%#{name}%")
    respond_to do |format|
        format.json {render json: @orders.to_json(:methods => [:id, :number, :name, :remain])}
    end
  end

  def new
    @order = order_type.new
  end

  def create
    @order = Order.new(order_params)
    respond_to do |format|
      if @order.save
        format.json { render json: @order }
      else
        format.json { render json: @order.errors }
      end
    end
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
