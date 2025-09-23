class ItemChecksController < ApplicationController

  def update
    @item_check = ItemCheck.find_by(item_id: params[:item_id], user_id: params[:user_id])
    if is_ok_value = params[:is_ok] == "true" || params[:is_ok] == "1"
      @item_check.update(is_ok: true)
      @item_check.update(is_ok: is_ok_value)
    end
    redirect_to group_items_path(params[:group_id])
  end
  
  def bulk_update
    # params[:item_checks] が [{"id"=>"3"}, {"id"=>"4"}] の形式なので id を取り出す
    checked_ids = params[:item_checks].map { |h| h[:id].to_i }
  
    # グループ内の全 ItemCheck を false にリセット
    group = Group.find(params[:group_id])
    ItemCheck.where(item_id: group.items.pluck(:id)).update_all(is_ok: false)
  
    # チェックされたものだけ true に更新
    ItemCheck.where(id: checked_ids).update_all(is_ok: true)
  
    redirect_to group_items_path(group)
  end

  private

  def order_detail_params
    params.require(:item_check).permit(:is_ok)
  end

end
