class PicturesController < ApplicationController
  
  def index
    @pictures = Picture.all
    @picture = Picture.new
  end
  
  def upload
    @picture = Picture.new(picture_params)
    if @picture.save
      redirect_to :back , notice: '画像の投稿が完了しました'
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    redirect_to :back, notice: "画像を削除しました!"
  end
  
  private
    def picture_params
      params.require(:picture).permit(:image, :alt, :row_order)
    end
    
end
