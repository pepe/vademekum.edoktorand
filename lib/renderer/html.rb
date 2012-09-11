require 'redcarpet'

module Renderer
  module Html
    def markdown2html(md)
      @html_renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML)
      @html_renderer.render(md)
    end
  end
end
