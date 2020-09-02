class Admin::UsersController < ApplicationController
  def new
    @admin_user = User.new
  end

  def create
    @admin_user = User.new(user_params)
    
    if @admin_user.save
      redirect_to admin_user_path(@user), notice: "ユーザー「#{@user .name}」を登録しました"
    else
      render  :new
    end
  end

  def edit
  end

  def show
  end

  def index
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_comfirmation, :admin)
  end

end
