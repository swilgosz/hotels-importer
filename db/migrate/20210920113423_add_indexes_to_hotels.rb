class AddIndexesToHotels < ActiveRecord::Migration[6.1]
  def change
    add_index :hotels, :external_id, unique: true
    add_index :hotels, :destination_id
  end
end
