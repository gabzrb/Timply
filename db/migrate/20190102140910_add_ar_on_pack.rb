class AddArOnPack < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :ar, :boolean, :default => false
  end
end
