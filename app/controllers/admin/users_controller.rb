class Admin::UsersController < ApplicationController
  
  before_action :user_authority
  before_action :set_user, only: %i[ edit update destroy show ]


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を登録しました"
    else
      render :new if @user.invalid?
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を編集しました"
    elsif @user.invalid?
      render :edit 
    else
      redirect_to admin_users_path, alert: "管理者ユーザーを0人することはできません"
    end
  end

  def index
    @users = User.select(:id, :name, :email, :admin).order(id: :asc).page(params[:page])
    @tasks_count = Task.all.count
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を削除しました"
    else
      redirect_to admin_users_path, alert: "管理者ユーザーを0人することはできません"
    end
  end

  def show
    @user_tasks = @user.tasks.order(created_at: :desc).page(params[:page])
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_comfirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_authority
    redirect_to tasks_path, alert: "管理者権限がありません" unless current_user_admin?
  end

end
