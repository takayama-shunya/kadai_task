class TasksController < ApplicationController

  before_action :set_task, only: [:edit, :show, :destroy, :update] 

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice: "タスク作成しました！"
      else
        render :new
      end
    end
  end

  def confirm
    @task = Task.new(task_params)
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

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content)
  end

end
