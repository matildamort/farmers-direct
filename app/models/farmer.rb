class Farmer < ApplicationRecord
  belongs_to :user
  has_many_attached :photo, dependent: :destroy 
end
