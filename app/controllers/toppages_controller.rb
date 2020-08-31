class ToppagesController < ApplicationController
  def index
    if logged_in? && !params[:format]
      #他ユーザのtoppagesにアクセスするための対策
      @books = current_user.books.order(id: :desc).page(params[:page])
      @user = current_user
      @count_midoku = current_user.books.where(status: '0').count
      @count_dokutyu = current_user.books.where(status: '1').count
      @count_dokuryo = current_user.books.where(status: '2').count
    elsif logged_in?
      @user = User.find(params[:format])
      @books = @user.books.order(id: :desc).page(params[:page])
      @count_midoku = @user.books.where(status: '0').count
      @count_dokutyu = @user.books.where(status: '1').count
      @count_dokuryo = @user.books.where(status: '2').count
    end
  end
end