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

  context "with badges" do
    subject { Account.create(login: 'koska',
                             name: 'Joska Koska') }
    it "can tell if has badge by its name" do
      subject.badges.create(name: 'toKlatovy')
      subject.should have_badge('toKlatovy')
    end
    it "can add badge by its name" do
      subject.add_badge('toKlatovy')
      subject.reload
      subject.should have_badge('toKlatovy')
    end
    it "can remove badge" do
      pending 'See if needed'
      subject.add_badge('toKlatovy')
      subject.remove_badge('toKlatovy')
      subject.reload
      subject.should_not have_badge('toKlatovy')
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

