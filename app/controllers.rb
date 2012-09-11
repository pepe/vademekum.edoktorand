#encoding: utf-8
Vademekum.controllers  do
  before do
    extend Utilities
    if params[:locale]
      I18n.locale = params[:locale]
    end
  end

  helpers do
    def current_account
      Account.first
    end
  end

  get :index do
    extend Renderer::Html
    @documents = columnize(Document.for_front_page)
    @questionnaires = columnize(Questionnaire.for_front_page)
    render 'index'
  end

  get :document, with: :id do
    extend Renderer::Html
    @document = Document.find(params[:id])
    render 'document'
  end

  get :edit, with: :id do
    @document = Document.find(params[:id])
    render 'edit'
  end

  post :update do
    @document = Document.find(params[:id])
    @document.update_attributes(params[:document])
    redirect url(:index)
  end

  get :type, map: ':type' do
    extend Renderer::Html
    @documents = columnize(Document.all_with_type(params[:type]))
    render 'type'
  end

  get :questionnaire, with: :id do
    @questionnaire = Questionnaire.find(params[:id])
    render 'questionnaire'
  end
end
