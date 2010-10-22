class HomesController < ApplicationController
  def show
    @featured_projects = Project.limit(5)
  end
end
