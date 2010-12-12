require "spec_helper"

describe Comment do
  before(:each) do
    comment = Factory(
      :comment, 
      :project => Factory(:project), 
      :user => Factory(:user)
    )
  end
  
  describe "validations" do
    it { should validate_presence_of :body }
    it { should validate_presence_of :project_id }
    it { should validate_presence_of :user_id }
  end
end
