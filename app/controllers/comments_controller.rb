class CommentsController < ApplicationController
  
  def create
    # Blogをパラメータの値から探し出し,Blogに紐づくcommentsとしてbuildします。
    @comment = Blog.find(comment_params[:blog_id]).comments.build(comment_params)
    
    @blog = @comment.blog
    
    # 人間が書いているかどうかをチェック
    if verify_recaptcha(model: @comment) && @comment.save
      redirect_to blog_path(@blog), notice: 'コメントを投稿しました。'
    else
      redirect_to blog_path(@blog), notice: 'コメント投稿に失敗しました。'
    end
  end

  private
    # ストロングパラメーター
    def comment_params
      params.require(:comment).permit(:blog_id, :content, :name)
    end
end