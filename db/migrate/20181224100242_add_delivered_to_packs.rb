class AddDeliveredToPacks < ActiveRecord::Migration[5.2]
  def change
    add_column :packs, :delivered, :string
  end
end
