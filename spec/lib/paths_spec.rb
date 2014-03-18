#encoding utf-8
require "spec_helper"

class Sample
  include Paths
  attr_accessor :id
end

describe Paths do

  let(:sample) { Sample.new }

  it "has default path for PDF sheets" do
    expect(sample.sheets_path).to eq "public/sheets"
  end

  it "can change sheet path" do
    sample.sheets_path = "spec/fixtures/sheets"
    expect(sample.sheets_path).to eq "spec/fixtures/sheets"
  end

  context "with id set" do
    before do
      sample.sheets_path = "spec/fixtures/sheets"
      sample.id = "012345689abcdef"
    end

    it "returns path to account folder" do
      expect(sample.sheets_path).to eq "spec/fixtures/sheets/012345689abcdef"
    end

    it "returns path to particular account sheet" do
      expect(sample.sheet_path("fedcba9876543210")).to eq "spec/fixtures/sheets/012345689abcdef/fedcba9876543210.pdf"
    end

    it "can save sheet file to account sheet path" do
      expect(sample.save_sheet("fedcba9876543210", "spec/fixtures/sheet.pdf")).to be_truthy
    end

    it "copies actual file there" do
      sample.save_sheet("fedcba9876543210", "spec/fixtures/sheet.pdf")
      expect(File.exists?(sample.sheet_path("fedcba9876543210"))).to be_truthy
    end
  end
end
