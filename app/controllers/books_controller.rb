class BooksController < ApplicationController
  before_action :require_user_logged_in

  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      flash[:success] = '書籍を追加しました'
      redirect_to root_url
    else
      @books = current_user.books.order(id: :desc).page(params[:page])
      flash.now[:danger] = '書籍の追加に失敗しました'
      render :new
    end
  end

  def destroy
    @book = current_user.books.find_by(id: params[:id])
    @book.destroy
    flash[:success] = '書籍を削除しました'
    redirect_to root_url
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to root_url
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = '書籍を編集しました'
      redirect_to root_url
    else
      flash.now[:danger] = '書籍の編集に失敗しました'
      render :edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:status,:title,:author,:comment)
  end
  
end