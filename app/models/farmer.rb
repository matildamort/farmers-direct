class Farmer < ApplicationRecord
  belongs_to :user
  has_many_attached :photos

  #original code
  # validates :user_id, :uniqueness => { :scope => :user_id, 
  #   :message => "already exists" }

#shortened code

    validates :user_id, uniqueness: true
    
end
