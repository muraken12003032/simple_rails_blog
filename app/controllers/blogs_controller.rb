class BlogsController < ApplicationController
  
  def index
    @blogs = Blog.where(:status => true).order('id desc')
  end
  
  def edit
    @blog = Blog.find(params[:id])
  end
  
  def new
    @blog = Blog.new
  end
  
  def show
    @blog = Blog.find(params[:id])
    if @blog.status == false
      if current_user == nil
        redirect_to root_path, notice: "存在しないURLです"
        return
      end
    end
  end
  
  def myblogadmin
    
    # ログインしていないユーザの場合はログイン画面へリダイレクト
    if current_user == nil
      redirect_to new_session_path
      return
    end
    
    # 最新5件のブログを表示
    @blogs = Blog.order('id desc').first(5)
  end
  
  def create
    blog = Blog.new(blog_params)
    if blog.save
      redirect_to blogs_path, notice: "ブログを投稿しました"
    else
      render 'edit'
    end
  end
  
  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "ブログを編集しました!"
    else
      render 'edit'
    end
  end
  
  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path, notice: "ブログを削除しました!"
  end
  
  def confirm
    @blog = Blog.new(blogs_params)
    render :new if @blog.invalid?
  end
  
  private
    def blog_params
      params.require(:blog).permit(:title, :content, :tag, :genre, :status)
    end
end