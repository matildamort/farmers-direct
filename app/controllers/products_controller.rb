class ProductsController < ApplicationController

    def index
    end

    def show 
        @product = Product.find(params[id])
    end

    def new
        @prodcut = Product.new
    end
    

end
