class ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @items = Item.all
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
end
