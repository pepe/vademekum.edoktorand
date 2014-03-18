#encoding: utf-8
require 'renderer/questionnaire_pdf'
require 'pdf/inspector'

describe Renderer::Questionnaire::PDF do
  it { is_expected.to be }

  describe '#params' do
    subject { super().params }
    it { is_expected.to eq({}) }
  end

  describe '#questions' do
    subject { super().questions }
    it { is_expected.to eq([]) }
  end

  describe '#title' do
    subject { super().title }
    it { is_expected.to eq("") }
  end

  context "when initilized with params and questions" do
    let(:pdf) { Renderer::Questionnaire::PDF.new("Head sheet",
                                                 {"which-color"=>"red" },
                                                 [["Do you have head?", "check", "yes"], ["Which color?", "write", "Simply red"]]) }

    it "shows initialized title" do
      expect(pdf.title).to eq("Head sheet")
    end

    it "shows initialized params" do
      expect(pdf.params).to  eq({"which-color"=>"red" })
    end

    it "shows initialized questions" do
      expect(pdf.questions).to eq([["Do you have head?", "check", "yes"], ["Which color?", "write", "Simply red"]])
    end

    it "returns questions with answers" do
      expect(pdf.questions_with_answers).to eq([["Do you have head?", nil], ["Which color?", "red"]])
    end
  end

  context "when preparing PDF" do
    let(:pdf) { Renderer::Questionnaire::PDF.new("Head sheet",
                                                 {"do-you-have-head"=>"yes", "which-color"=>"red" },
                                                 [["Do you have head?", "check", "yes"], ["Which color?", "write", "Simply red"]]) }

    let(:strings) { PDF::Inspector::Text.analyze(File.open(pdf.prepare_file).read).strings }

    it "prepares PDF with title" do
      expect(strings.include?("Head sheet")).to be_truthy
    end

    it "prepares PDF with todays date" do
      expect(strings.include?(I18n::l(Date.today, format: :long))).to be_truthy
    end

    it "prepares PDF file with the questions" do
      expect(strings.include?("Do you have head?")).to be_truthy
    end

    it "prepares PDF file with the answers" do
      expect(strings.include?("red")).to be_truthy
    end
  end
end
