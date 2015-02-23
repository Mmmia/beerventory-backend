class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    auto_login(@user)

    if @user.save
      respond_to do |format|
        format.html { redirect_to :organizations }
        format.json { render json: @user }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: { errors: @user.errors } }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
