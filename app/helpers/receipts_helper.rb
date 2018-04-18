module ReceiptsHelper

  def customized_url
    "/" + params[:type].tableize if params[:type].in? receipt_types
  end

  private
  def receipt_types
    ["MarkReceipt", "IdenticalSearchReceipt", "SimilarSearchReceipt", "RectificationMarkReceipt"]
  end
end
