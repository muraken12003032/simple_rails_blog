class CommentsController < ApplicationController
  
  def create
    # Blogをパラメータの値から探し出し,Blogに紐づくcommentsとしてbuildします。
    @comment = Blog.find(comment_params[:blog_id]).comments.build(comment_params)
    
    @blog = @comment.blog
    
    # クライアント要求に応じてフォーマットを変更
    if @comment.save
      redirect_to blog_path(@blog), notice: 'コメントを投稿しました。'
    end
  end

  private
    # ストロングパラメーター
    def comment_params
      params.require(:comment).permit(:blog_id, :content, :name)
    end
end