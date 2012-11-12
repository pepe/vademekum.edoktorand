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
  end

  get :index do
    extend Renderer::Html
    @documents = columnize(Document.for_front_page)
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

  get :fill, with: :id do
    extend Renderer::Questionnaire
    @questionnaire = Questionnaire.find(params[:id])
    render 'questionnaire'
  end

  post :sheet do
    flash[:notification] = t(:submited_successfully)

    redirect url(:index)
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
