require 'renderer/html'

describe Renderer::Html do
  it "converts markdown to html" do
    extend Renderer::Html
    expect(markdown2html('*italic*')).to eq("<p><em>italic</em></p>\n")
  end
end
