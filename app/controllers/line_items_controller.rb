class LineItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :line_item_cruds, only: [:add_quantity, :reduce_quantity, :destroy]

  def new
    @line_item = LineItem.new
  end
 
  def edit
  end
  
  
  def create
     
    chosen_product = Product.find(params[:product_id]) # defines that the chosen product is the product user selected. 
    current_cart = @current_cart #defines the cart is the instance variable pulled from carts controller

      if current_cart.products.include?(chosen_product) 
        #pretty self explainatory. If the current cart already includes that product it will add one quantity. 
        @line_item = current_cart.line_items.find_by(:product_id => chosen_product)
        @line_item.quantity += 1
      else
        #if that chosen product is not already in cart, it creates it as a new line item and sets quantity to 1
        @line_item = LineItem.new
        @line_item.quantity += 1
        @line_item.cart = current_cart
        @line_item.product = chosen_product
        @line_item.price = chosen_product.price 
      end

    #Utilised methods below, used for multiple 
    cart_update_increase
    redirect
  end
      
  # Adds 1 to @line item, which then increases the cart quantity and current cart. Using methods below. 
  def add_quantity
    @line_item.quantity += 1
    cart_update_increase 
    redirect
  end
      
  #Same as ad, but reduce. 
  def reduce_quantity
    if @line_item.quantity >= 1
      @line_item.quantity -= 1
      cart_update_reduce
    else
      @line_item.quantity == 0
    end
    @line_item.save
    redirect
  end

  #Allows user to remove a line item completely from thier cart. 
  def destroy
      if @line_item.present?
      @line_item.price = @line_item.price * @line_item.quantity
      @line_item.destroy
      cart_update_reduce
      redirect
      end
  end

  private
      
      
  #Pretty sure this does nothing so commented out
    # def line_item_params
    #   params.require(:line_item).permit(:quantity, :product_id, :cart_id, :product_productpic)
    # end

    #Methods used throughout above, drying it.
    def line_item_cruds
      current_cart = @current_cart
      @line_item = LineItem.find(params[:id])
    end

    def cart_update_reduce
      updated_price = @current_cart.price - @line_item.price
      @current_cart.update(price: updated_price)
    end

    def cart_update_increase
      updated_price = @current_cart.price + @line_item.price
      @current_cart.update(price: updated_price)
      @line_item.save
    end
    
    def redirect
      redirect_to cart_path(@current_cart)
    end
    
end
