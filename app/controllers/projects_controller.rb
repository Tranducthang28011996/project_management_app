class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_project, only: :show

  def index
    @own_projects = current_user.projects
  end

  def create
  	@project = current_user.projects.build project_params
  	if @project.save
			redirect_to root_url
		else
			flash.now[:error] = "not show"
  	end
  end

  def show
  	@task = {
  		new: @project.tasks.any? ? @project.tasks.where(status_id: 1) : [],
  		in_process: @project.tasks.any? ? @project.tasks.where(status_id: 2) : [],
  		resolved: @project.tasks.any? ? @project.tasks.where(status_id: 3) : [],
  		testing: @project.tasks.any? ? @project.tasks.where(status_id: 4) : [],
  		done: @project.tasks.any? ? @project.tasks.where(status_id: 5) : []
  	} 
  end
  
  def new
  end

  private

  def project_params
  	params.require(:project).permit(:name, :description)
  end

  def load_project
  	@project = Project.find_by id: params[:id]
  	return if @project
  	redirect_to root_url
  end
end
