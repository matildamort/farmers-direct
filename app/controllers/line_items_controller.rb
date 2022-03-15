class LineItemsController < ApplicationController
  before_action :authenticate_user!

  def new
    @line_item = LineItem.new
  end
 
  def edit
  end
  
  def create
     
        chosen_product = Product.find(params[:product_id])
        current_cart = @current_cart
    
        if current_cart.products.include?(chosen_product)
          
          @line_item = current_cart.line_items.find_by(:product_id => chosen_product)
          @line_item.quantity += 1
        else
         
          @line_item = LineItem.new
          @line_item.quantity += 1
          @line_item.cart = current_cart
          @line_item.product = chosen_product
          @line_item.price = chosen_product.price 
        end
        updated_price = current_cart.price + @line_item.price
        current_cart.update(price: updated_price)
        @line_item.save
        redirect_to cart_path(current_cart)
      end

      def add_quantity
        current_cart = @current_cart
        @line_item = LineItem.find(params[:id])
        @line_item.quantity += 1
        updated_price = current_cart.price + @line_item.price
        current_cart.update(price: updated_price)
        @line_item.save
        redirect_to cart_path(@current_cart)
      end
      
      def reduce_quantity
        current_cart = @current_cart
        @line_item = LineItem.find(params[:id])
        if @line_item.quantity >= 1
          @line_item.quantity -= 1
          updated_price = current_cart.price - @line_item.price
          current_cart.update(price: updated_price)
        else
          @line_item.quantity == 0
        end
        @line_item.save
        redirect_to cart_path(@current_cart)
      end

      def destroy
        current_cart = @current_cart
        @line_item = LineItem.find(params[:id])
       if @line_item.present?
        @line_item.price = @line_item.price * @line_item.quantity
        @line_item.destroy
        updated_price = current_cart.price - @line_item.price
        current_cart.update(price: updated_price)
        redirect_to cart_path(current_cart)
      end
    end

      private
        def line_item_params
          params.require(:line_item).permit(:quantity, :product_id, :cart_id)
        end

        
end
