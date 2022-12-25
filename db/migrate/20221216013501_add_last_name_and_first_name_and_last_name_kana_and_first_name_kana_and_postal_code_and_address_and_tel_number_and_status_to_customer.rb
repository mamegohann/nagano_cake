class AddLastNameAndFirstNameAndLastNameKanaAndFirstNameKanaAndPostalCodeAndAddressAndTelNumberAndStatusToCustomer < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :last_name, :string, null: false
    add_column :customers, :first_name, :string, null: false
    add_column :customers, :last_name_kana, :string, null: false
    add_column :customers, :first_name_kana, :string, null: false
    add_column :customers, :postal_code, :integer, null: false
    add_column :customers, :address, :string, null: false
    add_column :customers, :tel_number, :integer, null: false
    add_column :customers, :status, :boolean, null: false, default: false
  end
end
