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

  def create
    
    #@amount = (@sum * 100).to_i 
    #puts @amount

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
    @order = Order.create(price: @subtotal)

    rescue Stripe::CardError => e
      flash[:error] = e.message

 
    @order.save
    redirect_to root_path
  end
  
  private

    #def order_params
      #params.require(:order).permit(:name,  :email, :address)
    #end

end
