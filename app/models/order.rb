class Order < ApplicationRecord
  belongs_to :line_item
  belongs_to :user
  
end
