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

  context "when searching" do
    before do
      5.times do |i|
        Document.create(name: "Basic #{i}",
                        desc: 'Some basic document',
                        type: i % 2 == 0 ? 'records' : 'expectations')
      end
    end

    context "for front page" do
      it "returns documents in columns" do
        Document.for_front_page.size.should == 5
      end
    end

    context "for type pages" do
      it "all documents" do
        Document.all_with_type('records').size.should == 3
      end
    end
  end
  context "with types" do
    it "returns if has type" do
      subject.type = 'records'
      subject.is_type?('records')
    end
  end

  after do
    Document.destroy_all
  end
end
