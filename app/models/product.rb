class Product < ApplicationRecord
 belongs_to :user
 has_one_attached :productpic
 has_many :line_items, dependent: :destroy 
 #has_many :user, through :orders
 
def self.search(search)
    where("lower(product.name) LIKE :search", search: "%#{search.downcase}%".uniq)
end

end
