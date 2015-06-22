class ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @items = Item.order(created_at: :desc)
    @new_item = Item.new
  end

  def create
    item_params = params[:item].permit(:name, :price, :picture)
    # item_params == {
    #   price: (the price),
    #   name: (the name)
    # }
    # => (after merge)
    # item_params == {
    #   price: (the price),
    #   name: (the name),
    #   user: (the current user)
    # }
    @item = Item.new(item_params.merge({user: current_user}))
    # TODO: change behavior below
    # binding.pry
    if @item.save
      redirect_to root_path, notice: "Item successfully created!"
    else
      redirect_to root_path, alert: "Item could not be created :("
    end
  end

  def buy
    @item = Item.find(params[:id])
    @amount = (@item.price * 100).round # placeholder

    customer = Stripe::Customer.create(
      :email => 'example@stripe.com',
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => "Purchased #{@item.name} on Pinterest",
      :currency    => 'usd'
    )
    redirect_to root_path, notice: "Success! You've purchased #{@item.name} :)"
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to root_path
  end

end






