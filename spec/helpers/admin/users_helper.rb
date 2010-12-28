require 'spec_helper'

describe Admin::UsersHelper, "#display_if_is?" do
  it "should display Enabled or Disabled for a given user/role" do
    user = Factory.build :user, :roles => 'admin field_operator'
    display_if_is?(user, 'admin').should == 'Enabled'
    display_if_is?(user, 'field_operator').should == 'Enabled'
    display_if_is?(user, 'organization_manager').should == 'Disabled'
  end
end
