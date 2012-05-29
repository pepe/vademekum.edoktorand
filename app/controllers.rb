#encoding: utf-8
Vademekum.controllers  do
  before do
    if params[:locale]
      I18n.locale = params[:locale]
    end
  end

  helpers do
    def menu_active?(item)
      item == request.env['PATH_INFO'] ? 'active' : ''
    end

    def menu_items
      { '/' => t(:wall, scope: :type),
        '/records' => t(:records, scope: :type),
        '/expectations' => t(:expectations, scope: :type),
        '/analysis' => t(:analysis, scope: :type),
        '/plan' => t(:plan, scope: :type) }
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
    @document = Document.find(params[:id])
    render 'document'
  end

  get :survey do
    render 'survey'
  end
end
