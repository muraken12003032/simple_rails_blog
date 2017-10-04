class PicturesController < ApplicationController
  
  def index
    @picture_last = Picture.last
    @picture = Picture.new
  end
  
  def upload
    @picture = Picture.new(picture_params)
    if @picture.save
      redirect_to root_path, notice: '画像の投稿が完了しました'
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
    def picture_params
      params.require(:picture).permit(:image, :alt, :row_order)
    end
    
end
