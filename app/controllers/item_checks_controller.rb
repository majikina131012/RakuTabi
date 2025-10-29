class ItemChecksController < ApplicationController

  def bulk_update
    group = Group.find(params[:group_id])
  
    if params[:item_checks].blank?
      redirect_to group_items_path(group), notice: "何も選択されていません"
      return
    end
  
    checked_ids = params[:item_checks].map { |h| h[:id].to_i }
  
    ItemCheck.where(item_id: group.items.pluck(:id)).update_all(is_ok: false)
    ItemCheck.where(id: checked_ids).update_all(is_ok: true)
  
    redirect_to group_items_path(group), notice: "チェックを更新しました"
  end

  private

  def order_detail_params
    params.require(:item_check).permit(:is_ok)
  end

end
