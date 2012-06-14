#encoding: utf-8
Vademekum.controllers  do
  before do
    if params[:locale]
      I18n.locale = params[:locale]
    end
  end

  get :index do
    @documents = columnize(Document.for_front_page)
    render 'index'
  end

  get :document, with: :id do
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
    @documents = columnize(Document.for_type_page(params[:type]))
    render 'type'
  end
end
