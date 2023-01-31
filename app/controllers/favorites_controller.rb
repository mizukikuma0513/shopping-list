class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    shop = Shop.find(params[:shop_id])
    current_user.favorite(shop)
    flash[:success] = 'ショップをお気に入りに追加しました。'
    redirect_to request.referer
  end

  def destroy
    shop = Shop.find(params[:shop_id])
    current_user.unfavorite(shop)
    flash[:success] = 'ショップをお気に入りから解除しました。'
    redirect_to request.referer
  end
end
