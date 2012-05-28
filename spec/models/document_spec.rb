require 'spec_helper'

describe Document do
  it "can be initialized" do
    subject.should respond_to(:new_record?)
  end

  context "with attributes" do
    subject { Document.create(name: 'Basic',
                              description: 'Some basic document',
                              body: '# Some basic document') }
    its(:name) { should eq('Basic') }
    its(:description) { should eq('Some basic document') }
    its(:body) { should eq('# Some basic document') }
  end

  after :all do
    Document.destroy_all
  end
end
