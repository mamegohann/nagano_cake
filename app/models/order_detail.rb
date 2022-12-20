class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order
  
  enum status: { not_start: 0, not_production: 1, production: 2, complete_production: 3}
end
