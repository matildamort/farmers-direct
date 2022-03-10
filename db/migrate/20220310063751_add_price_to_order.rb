class AddPriceToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :price, :float
  end
end
