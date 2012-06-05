Vademekum.helpers do
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

  def current_account
    Account.first
  end
end
