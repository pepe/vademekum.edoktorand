#encoding: utf-8
Vademekum.controllers  do
  before do
    extend Utilities
    if params[:locale]
      I18n.locale = params[:locale]
    end

    if !current_account && !request.path_info.match(/not_logged|authenticate/)
      redirect "not_logged"
    end
  end

  helpers do
    def current_account
      Account.find(session[:current_account]) if session[:current_account]
    end

    def current_type
      return @document.type if @document
      return params[:type] if params[:type]
      ''
    end

    def current_type_url
      url(:type, type: current_type)
    end

    def new_current_type_url
      url(:new, type: current_type)
    end
  end

  get :index do
    extend Renderer::Html
    @documents = columnize(Questionnaire.for_front_page)

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
    document = Document.find(params[:id])
    document.update_attributes(params[:document])

    redirect url(:type, type: document.type)
  end

  get :new, with: :type do
    extend Renderer::Html
    @document = Document.new(type: params[:type])

    render 'new'
  end

  post :create do
    document = Document.create(params[:document])

    redirect url(:type, type: document.type)
  end

  get :fill, with: :id do
    extend Renderer::Questionnaire
    @questionnaire = Questionnaire.find(params[:id])
    render 'questionnaire'
  end

  post :sheet, with: :id do
    questionnaire = Questionnaire.find(params[:id])
    account = current_account

    path = Renderer::Questionnaire::PDF.new(questionnaire.name,
                                           params,
                                           questionnaire.questions).prepare_file
    account.extend Paths
    account.save_sheet(questionnaire.id, path)

    content_type "application/pdf"
    send_file path, filename: questionnaire.name.parameterize + ".pdf"
  end

  get :not_logged do
    render "not_logged", layout: :no_user
  end

  get :authenticate, with: [:login, :token] do
    account = Account.where(login: params[:login]).first
    redirect url(:not_logged) unless account.authenticated?(params[:token])
    session[:current_account] = account.id.to_s
    redirect url(:index)
  end

  get :type, map: ':type' do
    extend Renderer::Html
    @documents = columnize(Document.all_with_type(params[:type]))
    render 'type'
  end
end
