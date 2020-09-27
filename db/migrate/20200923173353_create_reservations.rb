class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.datetime :valid_until
      t.integer :status, default: 0
      t.integer :selling_option
      t.string :email
      t.integer :quantity
      t.float :to_be_paid
      t.references :ticket, null: false, foreign_key: true

      t.timestamps
    end
  end
end
