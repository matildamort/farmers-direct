class CartsController < ApplicationController

  before_action :authenticate_user! , only: [:new, :create]

  def show
    @cart = @current_cart
  end

  #Empty's the cart of all items
  def destroy
    @cart = @current_cart
    @cart.destroy
    session[:cart_id] = nil
    redirect_to root_path
  end
end
