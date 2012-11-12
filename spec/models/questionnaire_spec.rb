require 'spec_helper'

describe Questionnaire do
  context "with attributes" do
    subject { Questionnaire.create(name: 'Basic',
                              desc: 'Some basic document',
                              body:
      "??? Do you have head?\n\nxxx\nyes\n\n??? How big?\n\n___ Here goes head size\n\n??? Color?\n\nooo\nred\nsimply red",
                              type: 'expectations') }

    its(:name) { should eq('Basic') }
    its(:desc) { should eq('Some basic document') }
    its(:questions) { should have(3).items }
    its(:type) { should eq('expectations') }

    context "with questions" do
      let(:questionnaire) { Questionnaire.create(name: 'Basic',
                            desc: 'Some basic document',
                            body:
      "??? Do you have head?\n\nxxx\nyes\n\n??? How big?\n\n___ Here goes head size\n\n??? Color?\n\nooo\nred\nsimply red",
                              type: 'expectations') }
      it "returs question as text, type and options for check question" do
        subject.questions.first.should == ['Do you have head?', 'check', ['yes']]
      end

      it "returs question as text, type and placeholder for write question" do
        subject.questions[1].should == ['How big?', 'write', 'Here goes head size']
      end

      it "returs question as text, type and options for choose question" do
        subject.questions.last.should == ['Color?', 'choose', ['red', 'simply red']]
      end
    end

    context "when sanitizing input" do
    let(:questionnaire) { Questionnaire.create(name: 'Basic',
                              desc: 'Some basic document',
                              body:
      "??? Do you have head?\r\n\r\nxxx\r\nyes\r\n\r\n??? How big?\r\n\r\n___ Here goes head size\r\n\r\n??? Color?\r\n\r\nooo\r\nred\nsimply red",
                              type: 'expectations') }
      it "it converts \\r\\n to \\n" do
        questionnaire.save
        questionnaire.body.should eql(
          "??? Do you have head?\n\nxxx\nyes\n\n??? How big?\n\n___ Here goes head size\n\n??? Color?\n\nooo\nred\nsimply red",
        )
      end
    end
  end
end

