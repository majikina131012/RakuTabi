class ItemChecksController < ApplicationController

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
