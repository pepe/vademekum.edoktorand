require 'i18n'

module Utilities
  I18n.load_path == Dir['app/locale/*.yml']

  def menu_active?(request, item)
    item == request.env['PATH_INFO'] ? 'active' : ''
  end

  def menu_items
    { '/' => I18n::t(:wall, scope: :type),
      '/records' => I18n::t(:records, scope: :type),
      '/expectations' => I18n::t(:expectations, scope: :type),
      '/analysis' => I18n::t(:analysis, scope: :type),
      '/plan' => I18n::t(:plan, scope: :type) }
  end

  def columnize(arr, cols = 3)
    return [] if arr.empty?
    in_column = arr.size / cols
    in_column += 1 if arr.size % cols != 0
    arr.each_slice(in_column)
  end

  def action_url(doc)
    [doc.is_a?(Questionnaire) ? :fill : :document, id: doc.id]
  end

  def action_class(doc)
    'btn' + (doc.is_a?(Questionnaire) ? ' btn-primary' : '')
  end

  def action(doc)
    doc.is_a?(Questionnaire) ? :fill : :view
  end

  def date_action(account, doc)
    if doc.is_a?(Questionnaire)
      account.extend Paths
      if File.exists?(file = account.sheet_path(doc.id))
        time = File.ctime(file)
        "<a href='/sheets/#{account.id}/#{doc.id}.pdf'>#{I18n::t :last_filled}: #{I18n::l(time, format: :short)}</a>"
      else
        I18n::t(:never_filled)
      end
    else
      "#{I18n::t :created_at}: #{I18n::l(doc.created_at, format: :short)}"
    end
  end
end

