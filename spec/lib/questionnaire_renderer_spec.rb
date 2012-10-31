require 'renderer/questionnaire'

describe Renderer::Questionnaire do
  before do
    extend Renderer::Questionnaire
  end

  it "renders check box question" do
    question(['Are you sure?', 'check', ['yes']]).should ==
"<p>Are you sure?</p><label>yes<input type='checkbox' name='are-you-sure' value='yes'/></label>"
  end

  it "renders text field question" do
    question(['Are you sure?', 'write', 'yes I am']).should ==
"<p>Are you sure?</p><input type='text' name='are-you-sure' value='yes I am'/>"
  end

  it "renders radio box field question" do
    question(['Color?', 'choose', ['red', 'simply red']]).should ==
"<p>Color?</p><label>red<input type='radio' name='color' value='red'/></label><label>simply red<input type='radio' name='color' value='simply red'/></label>"
  end
end

