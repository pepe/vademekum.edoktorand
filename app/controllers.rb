#encoding: utf-8
Vademekum.controllers  do
  helpers do
    def menu_active?(item)
      item == request.env['PATH_INFO'] ? 'active' : ''
    end

    def menu_items
      {'/' => 'Vše', '/survey' => 'Záznamy', '/documents' => 'Očekávání',
        '/analysis' => 'Analýza potřeb'}
    end

    def markdown2html(md)
      @html_renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML)
      @html_renderer.render(md)
    end
  end

  get :index do
    @documents = Document.all
    render 'index'
  end

  get :document, with: :id do
    @body = Document.find(params[:id]).body
    render 'markdown'
  end

  get :survey do
    render 'survey'
  end
end
