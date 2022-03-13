class ProductsController < ApplicationController
    before_action :authenticate_user! , only: [:new, :create]
    before_action :params_find , only: [:show, :edit, :update, :destroy ]
    before_action :isFarmer, only: [:new, :create, :edit, :update, :destroy]
    before_action :check_ownership, only: [:edit, :update, :destroy]
    



    def index
        @products = Product.all

    end

    def about
    end

    def new
        @product = Product.new
    end

    def show 
        
    end

    def create
        begin
            @product = Product.create(product_params)
            redirect_to products_path, notice: "Your product #{@product.name} is up for sale!"
            rescue StandardError => e
                puts e.message
                redirect_to products_path, notice: "There has been an error, your product wasn't created. Please try again or contact support"
            end
    end

    def destroy     
        @product.destroy
        redirect_to root_path, notice: "#{@product.name} was removed from product range"
    end

    def edit

    end

    def myproduct
        @products = Product.all
    end

    def update
        @product.update(product_params)
        redirect_to products_path, notice: "#{@product.name} updated"
    end


    private 

    def product_params
        params.require(:product).permit(:name, :description, :price, :stock, :productpic, :category, :user_id)
    end

def search 
    if params[:search].blank?
        redirect_to products_path, alert: "No products match your search" and return
    else
        @parameter = params[:search].downcase
    @results = Products.all.where("lower(name) LIKE :search", search: "%#{@parameter}%")
    end
end



    def find_product
        begin
            @product = Product.find(params[:id])
        rescue StandardError => e
            puts e.message
            #flash[:error] = e.message
            redirect_to product_path, alert: "No products match your search"
        end
    end

        

    def params_find
        @product = Product.find(params[:id])
    end

    def isFarmer
        if !current_user.farmer
            redirect_to products_path, alert: "You must be a registered farmer to access these pages"
        end
    end

    def check_ownership
        if !user_signed_in? and (!current_user.admin? or !current_user.id==@product.user_id) 
        redirect_to products_path, alert: "check ownership"
        end
    end
end
