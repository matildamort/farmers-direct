class Cart < ApplicationRecord

    has_many :line_items, dependent: :destroy
    has_many :products, through: :order_items
end
