class BlogsController < ApplicationController
  before_action :set_profile, :get_latest5
  
  def index
    @blogs = Blog.where(:status => true).order('id desc').page(params[:page])
    @noimage = Picture.find_by(:image => 'noimagenoimagenoimage.jpg')
    @logo = Picture.find_by(:image => 'logo_large.png')
  end
  
  def edit
    @blog = Blog.find(params[:id])
    prepare_meta_tags(title: "記事の編集")
  end
  
  def new
    @blog = Blog.new
    prepare_meta_tags(title: "記事の新規作成")
  end
  
  def show
    
    # IDからブログを取得
    @blog = Blog.find(params[:id])
    
    # descriptionを設定
    if @blog.description == nil
      # descriptionが未記入なら、本文の先頭100文字を記入
      description = @blog.content[0,100].gsub('#','')
    else
      description = @blog.description
    end
    
    # ブラウザのタブに表示されるtitleを記事のタイトルにする
    prepare_meta_tags(title: @blog.title, description: description)
    
    if @blog.status == false
      if current_user == nil
        redirect_to root_path, notice: "存在しないURLです"
        return
      end
    end
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
      #redirect_to blogs_path, notice: "ブログを編集しました!"
      redirect_to edit_blog_path(params[:id]), notice: "ブログを編集しました!"
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
  
  
  # 公開状態を制御(反転)
  def publish
    # 管理者以外ならエラーを返す
    if current_user == nil
      redirect_to root_path, notice: "存在しないURLです"
      return
    end
    
    # 反転の処理
    blog = Blog.find(params[:id])
    blog.status ^= true
    blog.save
    redirect_to myblogadmin_blogs_path, notice: '変更が完了しました'
  end
  
  # サムネイルの設定ページ
  def thumbnail
    
    # 管理者以外ならエラーを返す
    if current_user == nil
      redirect_to root_path, notice: "存在しないURLです"
      return
    end
    
    @blog = Blog.find(params[:id])
    @pictures = Picture.all.order('id desc')
    @upload = Picture.new
    
  end
  
  # 管理者ページ
  def myblogadmin
    
    # titleを修正
    prepare_meta_tags(title: "管理者ページ")
    
    # ログインしていないユーザの場合はログイン画面へリダイレクト
    if current_user == nil
      redirect_to new_session_path
      return
    end
    
    # 最新5件のブログを表示
    # →全件に修正
    @blogs = Blog.all.order('id desc')
  end
  
  private
    def blog_params
      params.require(:blog).permit(:title, :content, :tag, :genre, :status, :picture_id, :description)
    end
    
    def set_profile
      if Blog.find_by(:title => '--profile--') == nil
        @profile = Blog.new
        @profile.content = '<br>プロフィールが未登録です<br>ブログの件名を"--profile--"にして登録すると本文がこの部分に表示されます。'
      else
        @profile = Blog.find_by(:title => '--profile--')
      end
    end
    
    def get_latest5
      @latest5 = Blog.where(:status => true).order('id desc').limit(5)
    end
end