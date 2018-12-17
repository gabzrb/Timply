class AddFieldsToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :category, :string
    add_column :orders, :quantity, :integer
    add_column :orders, :weight, :string
  end
end
