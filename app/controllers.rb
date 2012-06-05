#encoding: utf-8
Vademekum.controllers  do
  before do
    if params[:locale]
      I18n.locale = params[:locale]
    end
  end

  get :index do
    @documents = Document.for_front_page
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
