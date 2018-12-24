class AddEconomiesOnOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :reduction, :string
  end
end
