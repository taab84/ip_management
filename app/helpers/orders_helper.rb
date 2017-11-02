module OrdersHelper
  def new_order
    @order = PayementOrder.new
  end

  def order_types
    ["M", "P"]
  end

  def order_type
    if params[:branch].in? order_types
      if params[:branch] = "M"
        return "MdOrder"
      elsif params[:branch] = "P"
        return "PdOrder"
      end
    end
  end
end
