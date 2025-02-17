# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.setouchino.cloud"

SitemapGenerator::Sitemap.create do
  # 全体
  add blogs_path, :priority => 0.7, :changefreq => 'daily'
  
  # 個別記事
  Blog.find_each do |blog|
    if blog.status == true
      add blog_path(blog.id), :lastmod => blog.updated_at
    end
  end
  
  # プライバシーポリシー
  add privacypolicy_path, :priority => 0.5, :changefreq => 'weekly'
  
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end
