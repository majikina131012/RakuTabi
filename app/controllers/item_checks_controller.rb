class ItemChecksController < ApplicationController

  def update
    @item_check = ItemCheck.find_by(item_id: params[:item_id], user_id: params[:user_id])
    if is_ok_value = params[:is_ok] == "true" || params[:is_ok] == "1"
      @item_check.update(is_ok: true)
      @item_check.update(is_ok: is_ok_value)
    end
    redirect_to group_items_path(params[:group_id])
  end

  private

  def order_detail_params
    params.require(:item_check).permit(:is_ok)
  end

end
