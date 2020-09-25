class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.string :name
      t.integer :quantity
      t.text :description
      t.integer :status
      t.float :price
      t.references :event, foreign_key: true, index: true

      t.timestamps
    end
  end
end
