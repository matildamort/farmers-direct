class Product < ApplicationRecord
 belongs_to :user
 has_one_attached :productpic
 has_many :line_items, dependent: :destroy 
 #has_many :user, through :orders
end
