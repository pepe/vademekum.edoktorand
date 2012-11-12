require 'spec_helper'

describe Account do
  subject { FactoryGirl.create(:account) }

  context "with attributes" do
    its(:login) { should eq('koska') }
    its(:name) { should eq('Joska Koska') }
    its(:role) { should be_nil }
  end

  context "with roles" do
    let(:account) { FactoryGirl.create(:accout) }

    it "is not admin by default" do
      subject.should_not be_admin
    end
  end
end

