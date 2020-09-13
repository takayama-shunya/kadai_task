class TasksController < ApplicationController

  before_action :set_task, only: %i[ edit show destroy update]

  def index
    @search_params = search_params
    if params[:search]
      @tasks = current_user.tasks.search(@search_params).page(params[:page])
      redirect_to tasks_path, notice: "検索タスクはありません" if @tasks.blank?
    elsif params[:sort_desc]
      @tasks = current_user.tasks.order("#{set_clumn_name}": :desc).page(params[:page])
    elsif params[:sort_asc]
      @tasks = current_user.tasks.order("#{set_clumn_name}": :asc).page(params[:page])
    else
      @tasks = current_user.tasks.order(created_at: :desc).page(params[:page])
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to task_path(@task.id), notice: "タスク作成しました！"
      else
        render :new
      end
    end
  end

  def confirm
    @task = current_user.tasks.build(task_params)
    render :new if @task.invalid?
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスク編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスク削除しました"
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :expired, :status, :priority, label_ids: [])
  end

  def set_clumn_name
    clumn_name = params[:name]
  end

  def search_params
    params.fetch(:search, {}).permit(:title, :status)
  end


end
