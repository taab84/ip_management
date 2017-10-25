class MdOrderable < Orderable
  belongs_to :order, class_name: "MdOrder", :foreign_key => "payement_order_id"
  belongs_to :receipt, class_name: "MdReceipt", :foreign_key => "receipt_id"
end
