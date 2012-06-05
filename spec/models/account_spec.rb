require 'spec_helper'

describe Account do
  context "with attributes" do
    subject { Account.create(login: 'koska',
                             name: 'Joska Koska',
                             role: 'admin') }
    its(:login) { should eq('koska') }
    its(:name) { should eq('Joska Koska') }
    its(:role) { should eq('admin') }
  end

  after :all do
    Account.delete_all
  end
end

