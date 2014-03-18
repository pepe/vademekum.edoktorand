require 'spec_helper'

describe Document do
  context "when searching" do
    before do
      5.times { FactoryGirl.create(:document) }
      FactoryGirl.create(:document, owner: 'tutor')
    end

    context "for front page" do
      it "returns documents in columns" do
        expect(Document.for_front_page.count).to eq(5)
      end

      it 'returns front page documents with owner' do
        expect(Document.for_front_page('tutor').count).to eq(6)
      end

      it 'returns all documents for admin' do
        expect(Document.for_front_page('admin').count).to eq(6)
      end
    end

    context "for type pages" do
      it "returns all documents" do
        expect(Document.all_with_type('records').size).to eq(3)
      end
    end
  end

  context "with types" do
    it "returns if has type" do
      subject.type = 'records'
      expect(subject).to be_typed('records')
    end
  end

  context 'with owners' do
    it 'can have owner type' do
      subject.owner = 'tutor'
      expect(subject).to be_owned_by('tutor')
    end

    context 'when searching' do
    end
  end
end
