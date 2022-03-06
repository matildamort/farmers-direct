class AddPriceToProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :price, :decimal, default: 0.0
  end
end
