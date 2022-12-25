class Destination < ApplicationRecord
  belongs_to :customer
  
  def address_display
    '〒' + destination_postal_code + ' ' + destination_address + ' ' + destination_name
  end

end
