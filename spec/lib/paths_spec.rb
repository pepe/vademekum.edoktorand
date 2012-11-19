#encoding utf-8
require "spec_helper"

describe Paths do
  before :all do
    class Sample
      include Paths
      attr_accessor :id
    end
  end

  let(:sample) { Sample.new }

  it "has default path for PDF sheets" do
    sample.sheets_path.should eq "public/sheets"
  end

  it "can change sheet path" do
    sample.sheets_path = "spec/fixtures/sheets"
    sample.sheets_path.should eq "spec/fixtures/sheets"
  end

  context "with id set" do
    before :all do
      sample.sheets_path = "spec/fixtures/sheets"
      sample.id = "012345689abcdef"
    end

    it "returns path to account folder" do
      sample.sheets_path.should eq "spec/fixtures/sheets/012345689abcdef"
    end

    it "returns path to particular account sheet" do
      sample.sheet_path("fedcba9876543210").should eq "spec/fixtures/sheets/012345689abcdef/fedcba9876543210.pdf"
    end

    it "can save sheet file to account sheet path" do
      sample.save_sheet("fedcba9876543210", "spec/fixtures/sheet.pdf").should be_true
    end

    it "copies actual file there" do
      sample.save_sheet("fedcba9876543210", "spec/fixtures/sheet.pdf")
      File.exists?(sample.sheet_path("fedcba9876543210")).should be_true
    end
  end
end
