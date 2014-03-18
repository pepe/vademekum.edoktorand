require 'spec_helper'

describe Account do
  subject { FactoryGirl.create(:account) }

  context "with attributes" do
    describe '#login' do
      subject { super().login }
      it { is_expected.to eq('koska') }
    end

    describe '#name' do
      subject { super().name }
      it { is_expected.to eq('Joska Koska') }
    end

    describe '#role' do
      subject { super().role }
      it { is_expected.to be_nil }
    end
  end

  context "with roles" do
    let(:account) { FactoryGirl.create(:account) }

    it "is not admin by default" do
      expect(subject).not_to be_admin
    end
  end

  context "with token" do
    let(:account) { FactoryGirl.create(:account) }

    it "does not authenticate empty token" do
      expect(account).not_to be_authenticated("")
    end

    it "authenticate right token" do
      expect(account).to be_authenticated("4a6f77a6de3d7b16e0e566fe9a7760fa4a657004")
   end
  end
end

