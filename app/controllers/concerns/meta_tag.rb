module MetaTag
  extend ActiveSupport::Concern
  
  include ActionView::Helpers::AssetUrlHelper
  
  included do
    before_action :prepare_meta_tags
  end
  
  private
  
  def prepare_meta_tags(options = {})
    #base = t('meta_tags.base')
    
    site = '瀬戸内の雲のように'
    description = 'クラウド時代についていけないアラサーエンジニアの技術メモ的なブログ'
    title = 'TOP'
    keywords = ["Linux","Ruby on Rails","クラウド","API"]
    viewport = 'width=device-width, initial-scale=1.0'
    #image = image_url('image.png')
    
    defaults = {
      site: site,
      title: title,
      description: description,
      keywords: keywords,
      viewport: viewport,
      
      # For Facebook?
      og: {
        url: request.url,
        title: title,
        description: description,
        site_name: site,
        type: 'article',
        #image: image
      }
    }
    
    options.reverse_merge!(defaults)
    
    set_meta_tags(options)
  end
end