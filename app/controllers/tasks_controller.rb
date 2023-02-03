class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
    if logged_in?
      @pagy, @tasks = pagy(current_user.tasks, items: 10)
      @shops = current_user.shops
      if params[:search] == ''
        @tasks = current_user.tasks.order(id: "DESC")
      elsif params[:search] == 'newpost'
        @tasks = current_user.tasks.order(id: "DESC")
      elsif params[:search] == 'oldpost'
        @tasks = current_user.tasks.all
      end
    else 
      render new_sessions_url
    end
  end
  
  def show
  end
  
  def new
    @shops = current_user.shops
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'Task が正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task が投稿されませんでした'
      render :new
    end
  end
  
  def edit
    @task = Task.find(params[:id])
    @shops = current_user.shops
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to tasks_path
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end
  
  
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = '新たにタスクを追加しました。'
      redirect_to root_url
    else
      @pagy, @tasks = pagy(current_user.tasks.order(id: :desc))
      @shops = current_user.shops
      flash.now[:danger] = '新規タスクの追加に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @task.destroy
    flash[:success] = 'タスクを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def task_params
    params.require(:task).permit(:shop_id, :number, :content)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
