class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :load_project, only: [:create, :update]

  def create
    params[:task][:user_id] = current_user.id
  	@task = @project.tasks.create task_params

    render json: {task:render_to_string(partial: "tasks/item_task", locals: {task: @task})}
  end

  def update
    @task = Task.find_by id: params[:task][:id]
    status = Status.find_by name: params[:task][:status]
    if status
      @task.update_attributes status_id: status.id
    end

    render json: {task: @task}
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
