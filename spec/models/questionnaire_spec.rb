require 'spec_helper'

describe Questionnaire do
  context "with questions" do
    let(:questionnaire) { FactoryGirl.create(:questionnaire) }

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
    let(:questionnaire) { FactoryGirl.create(:questionnaire,
                              body:
      "??? Do you have head?\r\n\r\nxxx\r\nyes\r\n\r\n??? How big?\r\n\r\n___ Here goes head size\r\n\r\n??? Color?\r\n\r\nooo\r\nred\nsimply red",
                              ) }
    it "it converts \\r\\n to \\n" do
      questionnaire.save
      questionnaire.body.should eql(
        "??? Do you have head?\n\nxxx\nyes\n\n??? How big?\n\n___ Here goes head size\n\n??? Color?\n\nooo\nred\nsimply red",
      )
    end
  end

  context "with sections" do
    let(:questionnaire) { FactoryGirl.create(:questionnaire_with_sections) }

    it "have section as first question" do
      questionnaire.questions.first.should == ["This section is about heads", "section", nil]
    end
  end
end

