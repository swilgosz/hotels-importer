class CreateHotels < ActiveRecord::Migration[6.1]
  def change
    create_table :hotels do |t|
      t.integer :destination_id
      t.jsonb :location
      t.string :amenities, array: true
      t.jsonb :images, array: true
      t.string :booking_conditions, array: true
      t.string :external_id
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
