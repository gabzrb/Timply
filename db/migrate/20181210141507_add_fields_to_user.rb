class AddFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :entreprise, :string
    add_column :users, :siret, :string
    add_column :users, :address, :string
  end
end
