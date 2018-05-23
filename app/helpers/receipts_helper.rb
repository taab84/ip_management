module ReceiptsHelper

  def customized_url
    "/" + params[:type].tableize if params[:type].in? receipt_types
  end

  private
  def receipt_types
    ["MarkReceipt", "IdenticalSearchReceipt", "SimilarSearchReceipt", "RectificationMarkReceipt",  "DesignReceipt"]
  end

  def receipt_form_url
    if @receipt.new_record? 
      return (receipts_path({ :type => @receipt.type }))
    else
      return (receipt_path({ :type => @receipt.type, :id => @receipt.id }))
    end
  end
end
