class Addrferencetoorder < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :cart, index: true
  end
end
