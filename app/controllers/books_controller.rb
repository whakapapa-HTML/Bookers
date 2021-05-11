
class BooksController < ApplicationController

 protect_from_forgery except: :search # searchアクションを除外
 
def index
    @books = Book.all
    @book = Book.new
    # binding.pry
end

def create
    # paramsはRailsで送られてきた値を受け取るためのメソッド
     @book = Book.new(book_params)
    #  binding.pry
  if @book.save
     flash[:notice] = "Book was successfully created"
     redirect_to book_path(@book.id)
  else
    @books = Book.all.order(id: :desc)
    render ("books/index")
  end
end

def show
  @book = Book.find(params[:id])
end

def edit
  @book = Book.find(params[:id])
end

def update
    @book = Book.find(params[:id])
    @book.title = params[:title]
    @book.body = params[:body]
 if @book.update(book_params)
    flash[:notice] = "Book was successfully edited"
    redirect_to book_path(@book.id)
 else
  # ビューファイルを指定する booksフォルダの中のedit.html.erbのこと
    render ("books/edit")
 end
end

def destroy
  book = Book.find(params[:id])
  book.destroy
  flash[:notice] = "Book was successfully destroyed"
  redirect_to '/books'
end

private
def book_params
params.require(:book).permit(:title,:body)
end
end
