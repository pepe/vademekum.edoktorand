require 'spec_helper'

describe Document do
  subject { Document.create(name: 'Basic',
                            description: 'Some basic document',
                            body: '# Some basic document',
                            types: ['expectations', 'wall']) }

  context "with attributes" do
    its(:name) { should eq('Basic') }
    its(:description) { should eq('Some basic document') }
    its(:body) { should eq('# Some basic document') }
    its(:types) { should include('wall') }
  end

  after :all do
    Document.destroy_all
  end
end
