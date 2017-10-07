class ThumbnailsController < ApplicationController
  
  def new
    @thumbnail = Thumbnail.new
    @pictures = Picture.order('id desc').limit(5)
  end
  
  def create
    thumbnail = Thumbnail.new(thumbnail_params)
    #thumbnail.blog_id = thumbnail_params(thumbnail: [:blog_id])
    #thumbnail.picture_id = thumbnail_params(:picture_id)
    #thumbnail.blog_id = thumbnail_params(:blog_id)
    #thumbnail.picture_id = thumbnail_params(thumbnail: [:picture_id])
    
    if thumbnail.save!
      redirect_to myblogadmin_blogs_path
    else
      render 'new'
    end
  end
  
  def edit
    @thumbnail = Thumbnail.find(params[:id])
    @pictures = Picture.order('id desc').limit(5)
  end
  
  def update
    thumbnail = Thumbnail.find(params[:id])
    
    if thumbnail.update(thumbnail_params)
      redirect_to myblogadmin_blogs_path
    else
      render 'new'
    end
  end
  
  private
    def thumbnail_params
      params.require(:thumbnail).permit(:picture_id, :blog_id)
    end
end