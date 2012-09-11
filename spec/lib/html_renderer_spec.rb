require 'renderer/html'

describe Renderer::Html do
  it "converts markdown to html" do
    extend Renderer::Html
    markdown2html('*italic*').should == "<p><em>italic</em></p>\n"
  end
end
