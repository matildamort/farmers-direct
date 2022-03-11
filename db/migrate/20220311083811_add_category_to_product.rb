class AddCategoryToProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :category, :string
  end
end
