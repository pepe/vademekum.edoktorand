#encoding: utf-8
require 'renderer/questionnaire_pdf'
require 'pdf/inspector'

describe Renderer::Questionnaire::PDF do
  it { should be }

  its(:params) { should eq({}) }

  its(:questions) { should eq([]) }

  its(:title) { should eq("") }

  context "when initilized with params and questions" do
    let(:pdf) { Renderer::Questionnaire::PDF.new("Head sheet",
                                                 {"which-color"=>"red" },
                                                 [["Do you have head?", "check", "yes"], ["Which color?", "write", "Simply red"]]) }

    it "shows initialized title" do
      pdf.title.should eq("Head sheet")
    end

    it "shows initialized params" do
      pdf.params.should  eq({"which-color"=>"red" })
    end

    it "shows initialized questions" do
      pdf.questions.should eq([["Do you have head?", "check", "yes"], ["Which color?", "write", "Simply red"]])
    end

    it "returns questions with answers" do
      pdf.questions_with_answers.should == [["Do you have head?", nil], ["Which color?", "red"]]
    end
  end

  context "when preparing PDF" do
    let(:pdf) { Renderer::Questionnaire::PDF.new("Head sheet",
                                                 {"do-you-have-head"=>"yes", "which-color"=>"red" },
                                                 [["Do you have head?", "check", "yes"], ["Which color?", "write", "Simply red"]]) }

    let(:strings) { PDF::Inspector::Text.analyze(File.open(pdf.prepare_file).read).strings }

    it "prepares PDF with title" do
      strings.include?("Head sheet").should be_true
    end

    it "prepares PDF with todays date" do
      strings.include?(I18n::l(Date.today, format: :long)).should be_true
    end

    it "prepares PDF file with the questions" do
      strings.include?("Do you have head?").should be_true
    end

    it "prepares PDF file with the answers" do
      strings.include?("red").should be_true
    end
  end
end
