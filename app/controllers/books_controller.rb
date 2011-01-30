class BooksController < ApplicationController
  
  before_filter :require_user, :except => :index
  
  respond_to :html, :json
  respond_to :html, :json, :rss, :only => :index
  
  # GET /books
  # GET /books.json
  def index
    respond_with(@books = Book.finished.order('ended DESC').all)
  end

  # GET /books/1
  # GET /books/1.json
  def show
    respond_with(@book = Book.find(params[:id]))
  end

  # GET /books/new
  # GET /books/new.json
  def new
    respond_with(@book = Book.new)
  end

  # GET /books/1/edit
  def edit
    respond_with(@book = Book.find(params[:id]))
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(params[:book])
    if @book.save
      respond_with @book, :status => :created, :location => @book
    else
      respond_with @book.errors, :status => :unprocessable_entity do |format|
        format.html { render :action => :new }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.json
  def update
    @book = Book.find(params[:id])

    if @book.update_attributes(params[:book])
      respond_with @book, :location => @book do |format|
        format.json do
          head :ok
        end
      end 
    else
      respond_with @book.errors, :status => :unprocessable_entity do |format|
        format.html { render :action => :edit }
      end
    end
      
  end

  # DELETE /books/1
  # DELETE /books/1.xml
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to(books_url) }
      format.xml  { head :ok }
    end
  end
end
