require 'spec_helper'

describe Account do
  subject { FactoryGirl.create(:account) }

  context "with attributes" do
    its(:login) { should eq('koska') }
    its(:name) { should eq('Joska Koska') }
    its(:role) { should be_nil }
  end

  context "with roles" do
    let(:account) { FactoryGirl.create(:account) }

    it "is not admin by default" do
      subject.should_not be_admin
    end
  end

  context "with token" do
    let(:account) { FactoryGirl.create(:account) }

    it "does not authenticate empty token" do
      account.should_not be_authenticated("")
    end

    it "authenticate right token" do
      account.should be_authenticated("4a6f77a6de3d7b16e0e566fe9a7760fa4a657004")
   end
  end
end

