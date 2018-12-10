class CreatePacks < ActiveRecord::Migration[5.2]
  def change
    create_table :packs do |t|
      t.string :title
      t.string :category
      t.integer :weight
      t.integer :quantity

      t.timestamps
    end
  end
end
