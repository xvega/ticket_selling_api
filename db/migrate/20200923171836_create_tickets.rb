class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.integer :quantity
      t.string :owner_email
      t.string :owner_name
      t.text :description
      t.integer :status
      t.references :ticket_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
