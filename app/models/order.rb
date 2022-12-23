class Order < ApplicationRecord
  
  belongs_to :customer
  has_many :order_details
  has_many :items, through: :order_details
  
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { not_payment: 0, confirm_payment: 1, production: 2, shipping_preparation: 3, shipped: 4 }
  
  def subtotal
    item.add_tax_price * quantity
  end
  
  def add_tax_price
    (self.price * 1.10).round
  end
  
end
