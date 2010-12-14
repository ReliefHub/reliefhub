require 'spec_helper'

describe CommentsController do

  let(:project) { Factory :project }
  let(:user) { Factory :user }
  before do
    Project.stubs(:find=>project)
    User.stubs(:find=>user)
  end

  describe 'create' do
    let(:comment) { Factory.stub(:comment) }
    before do
      Comment.stubs(:new=>comment)
      comment.stubs(:body=>'my comment')
    end

    describe 'succeeds' do
      before do
        comment.stubs(:save=>true)
        controller.stubs(:current_user => user)
        request.env["HTTP_REFERER"] = "http://test.host/projects/"+project.id.to_s
        post :create, :comment=>stub, :project_id=>project
      end
      it { should redirect_to(:back) }
      it { should set_the_flash.to("Comment was successfully created.") }
      
    end

    describe 'failing' do
      before do
        comment.stubs(:save=>false)
        controller.stubs(:current_user => user)
        request.env["HTTP_REFERER"] = "http://test.host/projects/"+project.id.to_s
        post :create, :comment=>stub, :project_id=>project
      end
      it { should redirect_to(:back) }
      it { should set_the_flash.to("Error saving your comment - ") }
    end
  end
end
