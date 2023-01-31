class ToppagesController < ApplicationController
  def index
    @task = Task.new
    @shops = current_user.shops
    @pagy, @tasks = pagy(current_user.tasks, items: 15)
    @favorite_shops = current_user.likes
  end
  
  private
  def task_params
    params.require(:task).permit(:shop_id, :number, :content)
  end
end
