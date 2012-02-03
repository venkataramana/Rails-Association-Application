class BooksController < ApplicationController
        def index
                if !params[:limit].nil?
                        if params[:limit] != "all"
                                @limit= params[:limit].to_i
                        end
                else
                        @limit = 5
                end

                if !params[:value].nil? && !@limit.nil?
                @offset = (params[:value].to_i-1) * @limit
                else
                @offset = 0
                end
                @books_count=Book.count()
                if !@limit.nil?
                        @prev = params[:value].to_i > 1 ? (params[:value].to_i-1) : nil
                        @next = params[:value].to_i < (Book.count()/@limit)+1 ? (params[:value].to_i+1) : nil
                        @page = (@books_count/@limit.to_i).ceil
                        #render :text=>@page.inspect and return false
                        @books=Book.find(:all, :order=> "created_at DESC", :limit=>@limit, :offset=>@offset)
                else
                        @books=Book.find(:all, :order => "created_at DESC")
                end  # select , Group[ , Orderusers?page=3
                #@count_record=@books.count()
        end
        def new
                @book=Book.new
        end
        def create
                @book=Book.new(params[:book])
                if @book.save
                        redirect_to "/books"
                else
                        render :action=> "new"
                end
        end
end

