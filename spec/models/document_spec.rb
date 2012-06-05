require 'spec_helper'

describe Document do
  context "with attributes" do
    subject { Document.create(name: 'Basic',
                              desc: 'Some basic document',
                              body: '# Some basic document',
                              type: 'expectations') }

    its(:name) { should eq('Basic') }
    its(:desc) { should eq('Some basic document') }
    its(:body) { should eq('# Some basic document') }
    its(:type) { should eq('expectations') }
  end

  context "for front page" do
    before do
      5.times do |i|
        Document.create(name: "Basic #{i}",
                        desc: 'Some basic document')
      end
    end

    it "returns documents in columns" do
      Document.for_front_page.to_a.size.should == 3
    end
  end

  after :all do
    Document.destroy_all
  end
end
