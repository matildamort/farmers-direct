class Product < ApplicationRecord
 belongs_to :user
 has_one_attached :productpic
 has_many :order_items, dependent: :destroy 
end
