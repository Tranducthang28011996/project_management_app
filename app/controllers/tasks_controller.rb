class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :load_project, only: :create

  def create
    params[:task][:user_id] = current_user.id
  	@task = @project.tasks.create task_params
            
    render json: {task:render_to_string(partial: "tasks/item_task", locals: {task: @task})}
  end

  private

  def load_project
  	@project = Project.find_by id: params[:project_id]
  	return if @project
  	redirect_to root_url	
  end

  def task_params
    params.require(:task).permit(:name, :status_id, :user_id)
  end
end