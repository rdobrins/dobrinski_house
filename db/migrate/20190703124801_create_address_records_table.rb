class CreateAddressRecordsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :address_records do |t|
      t.string :ip_address, null: false
      t.datetime :last_visited, null: false, default: Time.now
      t.timestamps
    end
  end
end
