class ShopsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @shop = Shop.new
    @pagy, @shops = pagy(current_user.shops, items: 10)
    if params[:search] == ''
      @shops = current_user.shops.order(id: "DESC")
    elsif params[:search] == 'newshop'
      @shops = current_user.shops.order(id: "DESC")
    elsif params[:search] == 'oldshop'
      @shops = current_user.shops.all
    elsif params[:search] == 'favorite'
      @shops = current_user.likes
    end
  end

  def show
  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = current_user.shops.build(shop_params)

    if @shop.save
      flash[:success] = '新規ショップが正常に登録されました'
      redirect_to shops_path
    else
      flash.now[:danger] = '新規ショップを登録できませんでした'
      @favorite_shops = current_user.likes
      @shops = current_user.shops
      @shop = Shop.new
      @pagy, @shops = pagy(current_user.shops, items: 5)
      if params[:search] == ''
        @shops = current_user.shops.order(id: "DESC")
      elsif params[:search] == 'newshop'
        @shops = current_user.shops.order(id: "DESC")
      elsif params[:search] == 'oldshop'
        @shops = current_user.shops.all
      elsif params[:search] == 'favorite'
        @shops = current_user.likes
      end
      render :index
    end
  end

  def edit
    @shop = Shop.find(params[:id])
  end

  def update
    @shop = Shop.find(params[:id])
    if @shop.update(shop_params)
      flash[:success] = 'ショップ名を更新しました'
      redirect_to shops_path
    else
      flash.now[:danger] = 'ショップ名を更新できませんでした'
      @shop = Shop.find(params[:id])
      render :edit
    end
  end

  def destroy
    @shop = Shop.find(params[:id])
    @shop.destroy
    flash[:success] = 'ショップ名を削除しました'
    redirect_to shops_url
  end
  
  def items
    @shop = current_user.shops.find_by(id: params[:id])
  end
   
   
  private
  def shop_params
    params.require(:shop).permit(:name)
  end
  
  def correct_user
    @shop = current_user.shops.find_by(id: params[:id])
    unless @shop
      redirect_to root_url
    end
  end
end
