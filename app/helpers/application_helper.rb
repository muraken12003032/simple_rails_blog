module ApplicationHelper
  require 'redcarpet'
  require 'rouge'
  require 'rouge/plugins/redcarpet'
  
  @@toc = Redcarpet::Markdown.new Redcarpet::Render::HTML_TOC
  
  def markdown(text)
    render_options = {
      filter_html: false,
      hard_wrap: true,
      with_toc_data: true
    }
    
    #renderer = Redcarpet::Render::HTML.new(render_options)
    renderer = ::CustomMarkdownRenderer.new(render_options)
    
    extensions = {
      autolink: true,
      fenced_code_blocks: true,
      lax_spacing: true,
      no_intra_emphasis: true,
      strikethrough: true,
      superscript: true,
      tables: true,
    }
    
    Redcarpet::Markdown.new(renderer, extensions).render(text).html_safe
  end
  
  def table_of_content(text)
    @@toc.render(text).html_safe
  end
end
