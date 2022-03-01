class ProductsController < ApplicationController

    before_action :load_data


    def index
  
    end

    def show 
        @product = @products.find{|p| p.id == params[:id].to_i}
    end

    def new
        @products = Product.new
    end
    
    class Product 
        attr_reader :id, :name, :description, :price, :stock, :picture
        def initialize (id,name, description, price, stock, picture )
        @id = id
        @name = name
        @description = description
        @price = price
        @stock = stock
        @picture = picture
        end
    end 

    def load_data
        @products = [
            Product.new(1,"apples", "super juicy", 2.5, 10, "picture"),
            Product.new(2, "apples", "super juicy", 2.5, 10, "picture"),
            Product.new(3, "apples", "super juicy", 2.5, 10, "picture"),
            Product.new(4, "apples", "super juicy", 2.5, 10, "picture"),
        ]
    end


end
