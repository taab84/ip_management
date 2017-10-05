json.extract! receipt, :id, :owner_name, :owner_adress, :representative, :created_at, :updated_at
json.url receipt_url(receipt, format: :json)
