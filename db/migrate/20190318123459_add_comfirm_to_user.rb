class AddComfirmToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :comfirm_data, :boolean
  end
end
