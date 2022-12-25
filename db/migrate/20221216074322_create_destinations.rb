class CreateDestinations < ActiveRecord::Migration[6.1]
  def change
    create_table :destinations do |t|
      
      t.integer :customer_id,            null: false
      t.string :destination_name,        null: false
      t.string :destination_postal_code, null: false
      t.string :destination_address,     null: false
      t.timestamps
      
    end
  end
end
