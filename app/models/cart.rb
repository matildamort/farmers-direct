class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items
  has_many :orders

  # LOGIC
  def sub_total
    sum = 0
    self.line_items.each do |line_item|
      puts "#{line_item.product.name}"
      sum+= line_item.price
    end
    return sum
  end
end