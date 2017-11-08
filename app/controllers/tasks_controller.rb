class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :load_project, only: %i(show create update update_status)

  def create
    params[:task][:user_id] = current_user.id
  	@task = @project.tasks.create task_params

    render json: {task:render_to_string(partial: "tasks/item_task", locals: {task: @task})}
  end

  def show
    @task = @project.tasks.includes(:status).find_by id: params[:id]
    render json: {
      task: render_to_string(partial: "tasks/modal_task", locals: {task: @task, project: @project})
    }
  end

  def update
    @task = @project.tasks.find_by id: params[:id]
    if @task
      @task.update_attributes description: params[:task][:description]
    end

    render json: {task: @task}
  end

  def update_status
    @task = @project.tasks.find_by id: params[:id]
    status = Status.find_by name: params[:task][:status]

    if status && @task
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
    params.require(:task).permit(:name, :status_id, :user_id, :description)
  end
end
