class LineItemsController < ApplicationController

    
  
  def create
     
        chosen_product = Product.find(params[:product_id])
        puts "name #{chosen_product.name}"
        current_cart = @current_cart
        puts "cart #{current_cart}"
    
        if current_cart.products.include?(chosen_product)
          puts "if"
          @line_item = current_cart.line_items.find_by(:product_id => chosen_product)
          @line_item.quantity += 1
          @line_item.price = chosen_product.price * @line_item.quantity
        else
          puts "else"
          @line_item = LineItem.new
          @line_item.cart = current_cart
          @line_item.product = chosen_product
          @line_item.price = chosen_product.price 
          #@line_item = LineItem.create()
        end
      
        @line_item.save
        redirect_to cart_path(current_cart)
      end


      def add_quantity
        @line_item = LineItem.find(params[:id])
        @line_item.quantity += 1
        @line_item.price = @line_item.product.price * @line_item.quantity
        @line_item.save
        redirect_to cart_path(@current_cart)
      end
      
      def reduce_quantity
        @line_item = LineItem.find(params[:id])
        if @line_item.quantity > 1
          @line_item.quantity -= 1
          @line_item.price = @line_item.product.price * @line_item.quantity
        end
        @line_item.save
        redirect_to cart_path(@current_cart)
      end

      
      private
        def line_item_params
          params.require(:line_item).permit(:quantity, :product_id, :cart_id)
        end
end
