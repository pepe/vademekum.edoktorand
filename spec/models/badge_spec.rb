require 'spec_helper'

describe Badge do
  context "with attributes" do
    subject { Badge.new(name: 'toKlatovy', awarded_at: Time.now) }
    its(:name) { should eq('toKlatovy') }
    its(:awarded_at) { should < Time.now }
  end
end

