class ItemsController < ApplicationController
  
  def create
    @item = Item.new(item_params)
    @group = Group.find(params[:group_id])
    @item.group_id = @group.id
    if @item.save
      redirect_to group_items_path(@group.id)
    else
      @items = Group.items
      render :index
    end
  end

  def index
    @group = Group.find(params[:group_id])
    @item = Item.new
    @items = @group.items
  end

  def edit
    @group = Group.find(params[:group_id])
    @item = Item.find(params[:id])
  end

  def update
    @group = Group.find(params[:group_id])
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to group_items_path(@group.id)
    else
      render :edit
    end
  end

  def destroy
    group = Group.find(params[:group_id])
    item = Item.find(params[:id])
    item.destroy
    redirect_to group_items_path(group.id)
  end

  private

  def item_params
    params.require(:item).permit(:name, :remarks)
  end

end
