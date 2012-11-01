require 'renderer/questionnaire'

describe Renderer::Questionnaire do
  before do
    extend Renderer::Questionnaire
  end

  it "renders check box question" do
    question(['Are you sure?', 'check', ['yes']]).should ==
      "<p class='question'>Are you sure?</p><div class='answer'><label><input type='checkbox' name='are-you-sure' value='yes'/>&nbsp;yes</label></div>"
  end

  it "renders text field question" do
    question(['Are you sure?', 'write', 'yes I am']).should ==
      "<p class='question'>Are you sure?</p><textarea class='answer' placeholder='yes I am' name='are-you-sure'></textarea>"
  end

  it "renders radio box field question" do
    question(['Color?', 'choose', ['red', 'simply red']]).should ==
      "<p class='question'>Color?</p><div class='answer'><label><input type='radio' name='color' value='red'/>&nbsp;red</label></div><div class='answer'><label><input type='radio' name='color' value='simply red'/>&nbsp;simply red</label></div>"
  end
end

