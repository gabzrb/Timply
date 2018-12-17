class AddInfoToPacks < ActiveRecord::Migration[5.2]
  def change
    add_column :packs, :infos, :string
  end
end
