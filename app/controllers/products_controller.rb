class ProductsController < ApplicationController
    before_action :authenticate_user! , only: [:new, :create]
    before_action :params_find, only: [:show, :edit, :update, :destroy]
    before_action :isFarmer, only: [:new, :create, :edit, :update, :destroy, :myproduct]
    before_action :check_ownership, only: [:edit, :update, :destroy]
    


#Main product page, provides view of all products through instance variable. 
    def index
        @products = Product.all  
    end

    def new
        @product = Product.new
    end

    #def show - not required, not enough details on products. To remove description from model, serves no purpose if no show page. 


    #Controls the creation of new products and handles errors if unable to create the product. 
    def create
        begin
            @product = Product.create(product_params)
            redirect_to products_path, notice: "Your product #{@product.name} is up for sale!"
            rescue StandardError => e
                puts e.message
                redirect_to products_path, notice: "There has been an error, your product wasn't created. Please try again or contact support"
            end
    end
    # Allows farmers and admins to delete products
    def destroy     
        @product.destroy
        redirect_to root_path, notice: "#{@product.name} was removed from product range"
    end

    #Updates product by searching from product ID first (before_action), then using update method
    def edit
    end

    #Creates an instance variable so only items with set category is displayed in iteration. 
    def fruit
        @fruits = Product.where(category: "Fruit")
    end

    def vegetable
        @veggies = Product.where(category: "Vegetable")
    end

    def meat
        @meats = Product.where(category: "Meat")
    end

    def dairy
        @dairys = Product.where(category: "Dairy")
    end

    def pantry
        @pantrys = Product.where(category: "Pantry")
    end


    #Allows farmer to see own products. Products displayed is then controlled in the view to say only products belonging to that user to display. 
    def myproduct
        @products = Product.all
    end

    #Updates product by searching from product ID first
    def update
        @product.update(product_params) 
        redirect_to products_path, notice: "#{@product.name} updated" 
    end

    #Search feature 
    def search 
 
        if params[:search].nil? #this is not currently finctioning correctly. Added to bug fix.
           redirect_to products_path, alert: "No products match your search" and return
        else
            @parameter = params[:search].downcase #Prevents issues with capital titles of titles 
        @products = Product.all.where("lower(name) LIKE :search", search: "%#{@parameter}%") #searches the product paramaters and matches attributes. E.g can search by name but also price. 
        end
    end


    private 
#Defines what params belong to a product and what can be passed through the relavant forms and connect to that object. 
    def product_params
        params.require(:product).permit(:name, :description, :price, :productpic, :category, :user_id)
    end
   
#Used for a before aciton on multiple crud operations, finds the params of prodcuts and creates an instance variable. 
    def params_find
        @product = Product.find(params[:id])
    end
 
    # Prevents user accessing pages if they are not a farmer, e.g if they had a page saved or followed a link and they were not logged in or only logged in as a general user. 
    def isFarmer
        begin
        if user_signed_in? and !current_user.farmer
           # if user_signed_in? and (!current_user.farmer or !current_user.admin) - This should be the correct permission, however prevents farmer accessing elements. Add to bug fixes for future dev.
            redirect_to products_path, alert: "You must be a registered farmer to access these pages"
        else
        if !user_signed_in?
            redirect_to products_path, alert: "Please login as a farmer to access this page"
        end
    end
    # If all else fails redirects the user to the products page and displays message
        rescue StandardError => e
            puts e.message
            redirect_to products_path, alert: "Please login as a farmer to view"
        end
    end

    # This is a two prong approach, potentially redundand do the the way the site permissions have been set in index. Purpose is to prevent user deleting other peoples products; however this is handled in views. 
    def check_ownership
        if !user_signed_in? and (!current_user.admin? or !current_user.id==@product.user_id) 
        redirect_to products_path, alert: "check ownership"
        end
    end
end
