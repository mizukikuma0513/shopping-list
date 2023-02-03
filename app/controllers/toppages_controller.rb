class ToppagesController < ApplicationController
  def index
    if logged_in?
      @task = Task.new
      @shops = current_user.shops
      @pagy, @tasks = pagy(current_user.tasks, items: 5)
      @favorite_shops = current_user.likes
      counts(@user)
    end
  end
  
  def likes
    @task = Task.new
    @shops = current_user.shops
    @favorite_shops = current_user.likes
    @shop = current_user.shops.find_by(id: params[:id])
    @pagy, @tasks = pagy(@shop.tasks, item: 5)
    counts(@user)
  end
  
  
  private
  def task_params
    params.require(:task).permit(:shop_id, :number, :content)
  end
end
