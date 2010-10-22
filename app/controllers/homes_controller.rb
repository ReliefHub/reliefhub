class HomesController < ApplicationController
  def show
    @project = Project.first
  end
end
