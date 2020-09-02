class UsersController < ApplicationController
  
  before_action :set_user, only: %i[ show edit update destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: "ユーザー「#{@user .name}」を登録、ログインしました"
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

end
