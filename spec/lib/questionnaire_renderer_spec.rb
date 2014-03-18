require 'renderer/questionnaire'

describe Renderer::Questionnaire do
  before do
    extend Renderer::Questionnaire
  end

  it "renders check box question" do
    expect(question(['Are you sure?', 'check', ['yes']])).to eq(
      "<p class='question'>Are you sure?</p><div class='answer'><label><input type='checkbox' name='are-you-sure' value='yes'/>&nbsp;yes</label></div>"
    )
  end

  it "renders text field question" do
    expect(question(['Are you sure?', 'write', 'yes I am'])).to eq(
      "<p class='question'>Are you sure?</p><textarea class='answer' placeholder='yes I am' name='are-you-sure'></textarea>"
    )
  end

  it "renders radio box field question" do
    expect(question(['Color?', 'choose', ['red', 'simply red']])).to eq(
      "<p class='question'>Color?</p><div class='answer'><label><input type='radio' name='color' value='red'/>&nbsp;red</label></div><div class='answer'><label><input type='radio' name='color' value='simply red'/>&nbsp;simply red</label></div>"
    )
  end

  it "renders section header" do
    expect(question(["This section is about heads", "section", nil])).to eq "<h4>This section is about heads</h4>"
  end
end

