class PdOrderable < Orderable
  belongs_to :order, class_name: "PdOrder"
  belongs_to :receipt, class_name: "PdReceipt"
end
