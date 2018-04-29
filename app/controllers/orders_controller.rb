class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  load_and_authorize_resource

  def load
    query = params[:query]
    number = query.to_i
    @orders = Order.joins(:payement).selectized(query, number)
    respond_to do |format|
        format.json {render json: @orders.to_json(:methods => [:id, :number, :name, :remain])}
    end
  end

  def index
    @filterrific = initialize_filterrific(
      Order,
      params[:filterrific],
      select_options: {
        with_group_id: Group.options_for_select,
        with_type: Order.options_for_with_type,
        by_month: Order.options_for_by_month,
        sorted_by: Order.options_for_sorted_by
      },
      default_filter_params: { sorted_by: 'created_at_asc' },
    ) or return

    respond_to do |format|
      format.html {
        @orders = @filterrific.find.page(params[:page]).includes(:payement)
      }
      format.js {
        @orders = @filterrific.find.page(params[:page]).includes(:payement)
      }
      format.xlsx {
        @orders = @filterrific.find.includes(:payement)
        render xlsx: "orders", 
        template: 'orders/index', 
        disposition: 'inline', 
        locals: {xlsx_author: current_user.fullname}
      }
    end

    rescue ActiveRecord::RecordNotFound => e
      puts "Had to reset filter params: #{ e.message }"
      redirect_to(reset_filterrific_url(format: :html)) and return
  end

  def new
    @order = order_type.new
  end

  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    @order.group_id = current_user.group.id
    respond_to do |format|
      if @order.save
        format.json { render json: @order.to_json(:methods => [:id, :number, :name, :remain]) }
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
