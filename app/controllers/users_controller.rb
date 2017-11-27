class UsersController < ApplicationController
  before_action :find_user, only: %i(update show)

  def index
    @users = User.where("name LIKE '%#{params[:key_word]}%'").where.not(id: load_member_project).limit 5
    render json: {list_user: render_to_string(partial: "users/user", collection: @users)}
  end
  
  def show
    @projects = current_user.projects
    # @team_user = @project.get_member
    # @task = {
    #   new: @project.tasks.any? ? @project.tasks.where(status_id: 1).order("updated_at DESC") : [],
    #   in_process: @project.tasks.any? ? @project.tasks.where(status_id: 2) : [],
    #   resolved: @project.tasks.any? ? @project.tasks.where(status_id: 3) : [],
    #   testing: @project.tasks.any? ? @project.tasks.where(status_id: 4) : [],
    #   done: @project.tasks.any? ? @project.tasks.where(status_id: 5) : []
    # }
  end

  def edit; end

  def update_avatar

  end

  def update
    if @user.update_attributes params_user
      flash[:success] = "Update success!"
      redirect_to @user
    else
      flash[:error] = "Update no success!"
      redirect_to root_url
    end
  end

  private

  def params_user
    params.require(:user).permit :avatar, :name, :password, :email, :password_confirmation
  end

  def find_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless @user
  end

  def load_member_project
    @project = Project.find_by id: params[:project_id]
    return @project.get_member.pluck :id if @project
    []
  end
end
