class AddArOnPack < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :ar, :boolean, :default => false
    add_column :orders, :pb, :boolean, :default => false
    add_column :orders, :format, :string
  end
end
