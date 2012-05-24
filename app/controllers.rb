#encoding: utf-8
Vademekum.controllers  do
  helpers do
    def active(item)
      item == request.env['PATH_INFO'] ? 'active' : ''
    end

    def items
      {'/' => 'Vše', '/survey' => 'Záznamy a dokumentace', '/documents' => 'Očekávání',
        '/analysis' => 'Analýza potřeb', '/plans' => 'Plán osobního rozvoje'}
    end
  end

  get :index do
    render 'index'
  end

  get :documents do
    render 'document'
  end

  get :survey do
    render 'survey'
  end
end
