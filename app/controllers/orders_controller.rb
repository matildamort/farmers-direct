class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def sub_total
    @sum = 0
    self.line_items.each do |line_item|
      @sum+= line_item.price
    end
    return @sum
  end

  def new
    @order = Order.new
    @amount = (@current_cart.price * 100).to_i 
    puts @amount
  end

  #creates an order based on the cart and line-items functionality. Utilises stripe
  def create
    
    @amount = (@current_cart.price*100).to_i #stripe only accepts this format

    customer = Stripe::Customer.create(
      email: params[:stripeEmail], 
      source: params[:stripeToken]
    )

    puts customer
    charge = Stripe::Charge.create(
      customer:customer.id,
      amount: @amount,
      description: "payment for your order",
      currency: 'aud'
    )
    
    puts charge
    @order = Order.create(user: current_user, price: @current_cart.price)
      @current_cart.destroy #empty's the cart once the order has been processed. 
      session[:cart_id] = nil

    rescue Stripe::CardError => e
      redirect_to root_path, alert: e.message
  end
  
  private

  #Original design had user imputting details for delivery - to be re, implemented. 
    #def order_params
      #params.require(:order).permit(:name,  :email, :address)
    #end

end
