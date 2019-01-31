class AddFieldToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :prenom, :string
    add_column :users, :codepostal, :integer
    add_column :users, :ville, :string
  end
end
