class CartsController < ApplicationController

    def show
      @cart = @current_cart
    end
  
    def destroy
      @cart = @current_cart
      @cart.destroy
      session[:cart_id] = nil
      redirect_to root_path
    end


  def create
    @order = Order.new(order_params)
    @current_cart.order_items.each do |item|
      @order.order_items << item
      item.cart_id = nil
    end
    @order.save
    Cart.destroy(session[:cart_id])
    session[:cart_id] = nil
    redirect_to root_path
  end
  
  private
    def order_params
      params.require(:order).permit(:name, :email, :address, :pay_method)
    end
end
