class CartItem < ApplicationRecord

  belongs_to :item
  belongs_to :order

  # 小計を求めるメソッド
def subtotal
    item.add_tax_price * quantity
end

end
