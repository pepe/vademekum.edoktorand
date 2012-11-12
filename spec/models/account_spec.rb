require 'spec_helper'

describe Account do
  subject { Account.create(login: 'koska',
                           name: 'Joska Koska',
                           role: 'admin') }

  context "with attributes" do
    its(:login) { should eq('koska') }
    its(:name) { should eq('Joska Koska') }
    its(:role) { should eq('admin') }
  end

  end

  context "with roles" do
    it "returns if is admin" do
      subject.should be_admin
    end
  end

  after :all do
    Account.delete_all
  end
end

