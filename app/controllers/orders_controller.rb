class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.create(order_params)
    @order.save
    redirect_to root_path
  end
  
  private
    def order_params
      params.require(:order).permit(:name,  :email, :address, :line_item.price)
    end

end
