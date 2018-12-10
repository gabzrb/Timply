class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user
      t.references :pack
      t.integer :price
      t.string :tracking

      t.timestamps
    end
  end
end
