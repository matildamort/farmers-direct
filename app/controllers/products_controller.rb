class ProductsController < ApplicationController

    #before_action :find_product, only:[:show, :edit, :update, :destroy]
    #before_action :authenticate_user! , only: [:new, :create]
    #before_action :isFarmer [:new, :create, :edit, :update, :destroy]


    def index
        @products = Product.all
    
    end

    def new
        @product = Product.new
    end

    def show 
        @product = Product.find(params[:id])
    end

    def create
        Product.create(product_params)
        redirect_to products_path
       
    end

    def delete

    end

    def edit
    
    end


    def product_params
        params.require(:product).permit(:name, :description, :price, :stock, :productpic, :user_id)
    end

    

    def isFarmer
        if !current_user.farmer or !current_user.admin
            redirect_to products_path, alert: "You must be a registered farmer to add a product"
        end
    end

end
