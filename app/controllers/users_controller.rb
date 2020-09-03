class UsersController < ApplicationController
  
  skip_before_action :login_required, only: %i[ new create ]
  before_action :current_user_cannot_create_user, only: %i[ new create ]
  before_action :set_user, only: %i[ show edit update destroy]
  before_action :set_current_user, only: %i[ show edit update ]
  before_action :user_destroy_authority, only: [:destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: "ユーザー「#{@user .name}」を登録し、ログインしました"
    else
      render :new if @user.invalid?
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザー「#{@user .name}」を編集しました"
    else
      render :edit if @user.invalid?
    end
  end

  def show
  end

  def destroy
  end


  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_comfirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end


  def set_current_user
    redirect_to tasks_path, alert: "権限がありません" if current_user.id != @user.id && current_user.admin == false
  end

  def current_user_cannot_create_user
    redirect_to tasks_path, alert: "2人目のユーザー作成はできません" if current_user && current_user.admin == false
  end

  def user_destroy_authority
    redirect_to tasks_path, alert: "権限がありません" unless current_user.admin
  end

end
