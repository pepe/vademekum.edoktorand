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

  def columnize(arr, cols = 3)
    return [] if arr.empty?
    in_column = arr.size / cols
    in_column += 1 if arr.size % cols != 0
    arr.each_slice(in_column)
  end
end
