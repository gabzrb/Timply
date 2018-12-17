class AddFieldsToOrderForStripe < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :state, :string
    add_column :orders, :pack_sku, :string
    add_column :orders, :payment, :jsonb
    add_monetize :orders, :price, currency: { present: false }
  end
end
