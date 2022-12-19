class Admin::ItemsController < ApplicationController
  
  def index
    @items = Item.all
  end
  
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "You have created book successfully."
      redirect_to admin_items_path(@item.id)
    else
      @items = Item.all
      render :index
    end
  end
  
  def show
    @item = Item.find(params[:id])
  end
  
  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    @genres = Genre.all
    @item = Item.find(params[:id])
    if @item.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to admin_item_path(@item.id)
    else
      render :edit
    end
  end
  
  private

  def item_params
    params.require(:item).permit(:image, :genre_id, :name, :introduction, :price, :status)
  end
  
end
