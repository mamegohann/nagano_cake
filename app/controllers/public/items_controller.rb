class Public::ItemsController < ApplicationController

  def index
    @items = Item.page(params[:page]).per(8)
    @genres = Genre.all
    @genre = Genre.find_by(params[:genre_id])
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
  
end
