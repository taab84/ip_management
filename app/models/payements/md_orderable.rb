class MdOrderable < Orderable
  belongs_to :order, class_name: "MdOrder"
  belongs_to :receipt, class_name: "MdReceipt"
end
