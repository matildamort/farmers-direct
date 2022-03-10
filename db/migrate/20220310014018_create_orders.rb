class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :line_item, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :address
      t.string :email

      t.timestamps
    end
  end
end
