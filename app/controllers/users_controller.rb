class UsersController < ApplicationController
  #ログインが必須
  before_action :require_user_logged_in, only: [:index, :followings, :followers, :edit_user, :edit_profile]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザを登録し、ログインしました'
      session[:user_id] = @user.id
      redirect_to books_url
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました'
      render :new
    end
  end

  def edit_account
    @user = User.find(params[:format])
    if @user != current_user
      redirect_to books_url
    end
  end
  
  def edit_profile
    @user = User.find(params[:format])
    if @user != current_user
      redirect_to books_url
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = '更新しました'
      redirect_to books_url
    else
      flash.now[:danger] = '更新に失敗しました'
      @path = Rails.application.routes.recognize_path(request.referer)
      if @path[:action] == "edit_user"
        render :edit_account
      else
        render :edit_profile
      end
    end
  end
  
  #全ユーザ
  def index
    @user = @current_user
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end
  
  #フォローユーザ
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
  end
  
  #フォロワーユーザ
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
  end
end


private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,:image, :genre, :author, :comment)
  end