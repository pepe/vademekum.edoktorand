require 'spec_helper'

describe Document do
  subject { Document.create(name: 'Basic',
                            description: 'Some basic document',
                            body: '# Some basic document',
                            type: 'expectations') }

  context "with attributes" do
    its(:name) { should eq('Basic') }
    its(:description) { should eq('Some basic document') }
    its(:body) { should eq('# Some basic document') }
    its(:type) { should eq('expectations') }
  end

  after :all do
    Document.destroy_all
  end
end
