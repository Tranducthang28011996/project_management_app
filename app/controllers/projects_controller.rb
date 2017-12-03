class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_project, only: :show
  before_action :check_permission, only: :show
  
  def index
    @own_projects = current_user.projects
  end

  def create
  	@project = current_user.projects.build project_params
  	if @project.save
      @project.create_team name: "_team_project_#{@project.id}"
			redirect_to root_url
		else
			flash.now[:error] = "not show"
  	end
  end

  def show
    @team_user = @project.get_member
    @tasks = @project.tasks

    if params[:label]
      @tasks = @project.tasks.joins(:labels).where(labels: {id: params[:label]})
    end

    if params[:user]
      @tasks = @project.tasks.joins(:user).where(users: {id: params[:user]})
    end

  	@task = {
  		new: @tasks.any? ? @tasks.where(status_id: 1).order("updated_at DESC") : [],
  		in_process: @tasks.any? ? @tasks.where(status_id: 2) : [],
  		resolved: @tasks.any? ? @tasks.where(status_id: 3) : [],
  		testing: @tasks.any? ? @tasks.where(status_id: 4) : [],
  		done: @tasks.any? ? @tasks.where(status_id: 5) : []
  	}
    @labels = Label.all
    @users = @project.tasks.joins(:user).select("users.avatar, users.email, users.name, user_id")
      .group(:user_id, "users.avatar", "users.name", "users.email")

    respond_to do |format|
      format.js
      format.html
    end
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

  def check_permission
    return if @project.get_member.pluck(:id).include? current_user.id
    redirect_to root_url
  end
end
