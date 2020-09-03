class BooksController < ApplicationController
  before_action :require_user_logged_in

  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      flash[:success] = '書籍を追加しました。'
      redirect_to root_url
    else
      @books = current_user.books.order(id: :desc).page(params[:page])
      flash.now[:danger] = '書籍の追加に失敗しました。'
      render 'books/new'
    end
  end

  def destroy
    @book = current_user.books.find_by(id: params[:id])
    @book.destroy
    flash[:success] = '書籍を削除しました。'
    redirect_to root_url
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = '登録内容は正常に更新されました'
      redirect_to book_path(@book)
    else
      flash.now[:danger] = '登録内容は更新されませんでした'
      render :edit
    end
  end


  private

  def book_params
    params.require(:book).permit(:status,:title,:author,:comment)
  end
  
end