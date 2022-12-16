class Order < ApplicationRecord
  
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { not_payment: 0, confirm_payment: 1, production: 2, shipping_preparation: 3, shipped: 4 }
  
end
