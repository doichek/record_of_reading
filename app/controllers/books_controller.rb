class BooksController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    if logged_in? && !params[:format]
      #他ユーザのindexにアクセスするための対策
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
  
  def new
    @book = Book.new
    render "books/new&edit"
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      flash[:success] = '書籍を追加しました'
      redirect_to books_url
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
    redirect_to books_url
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_url
    end
    @path = "edit"
    render "books/new&edit"
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = '書籍を編集しました'
      redirect_to book_url
    else
      flash.now[:danger] = '書籍の編集に失敗しました'
      render :edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:status,:title,:author,:comment,:image)
  end
  
end