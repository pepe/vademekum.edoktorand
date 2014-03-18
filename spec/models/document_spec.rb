require 'spec_helper'

describe Document do
  context "with attributes" do
    subject { Document.create(name: 'Basic',
                              desc: 'Some basic document',
                              body: '# Some basic document',
                              type: 'expectations') }

    describe '#name' do
      subject { super().name }
      it { is_expected.to eq('Basic') }
    end

    describe '#desc' do
      subject { super().desc }
      it { is_expected.to eq('Some basic document') }
    end

    describe '#body' do
      subject { super().body }
      it { is_expected.to eq('# Some basic document') }
    end

    describe '#type' do
      subject { super().type }
      it { is_expected.to eq('expectations') }
    end
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
        expect(Document.for_front_page.size).to eq(5)
      end
    end

    context "for type pages" do
      it "all documents" do
        expect(Document.all_with_type('records').size).to eq(3)
      end
    end
  end
  context "with types" do
    it "returns if has type" do
      subject.type = 'records'
      subject.is_type?('records')
    end
  end
end
