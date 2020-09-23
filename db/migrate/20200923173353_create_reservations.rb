class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.time :valid_time
      t.integer :status
      t.string :selling_option
      t.references :ticket, null: false, foreign_key: true

      t.timestamps
    end
  end
end
