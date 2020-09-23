class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.float :amount
      t.string :token
      t.string :currency
      t.references :ticket, null: false, foreign_key: true

      t.timestamps
    end
  end
end
