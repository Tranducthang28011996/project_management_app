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

  def update_label
    @task = Task.find_by id: params[:id]
    label = Label.find_by id: params[:task][:label_id]
    format_error_js unless @task || label
    if params[:task][:checked] == "checked"
      @task.labels << label
    else
      @task.labels.delete label
    end

    render json: {
      status: true,
      data: {
        task_id: @task.id,
        label_in_modal: render_to_string(partial: "labels/label_in_modal", locals: {labels: @task.labels}),
        label_in_show_project: render_to_string(partial: "labels/label_in_show_project", locals: {labels: @task.labels})
      }
    }
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

  def format_error_js
    render json: {
      status: false
    }
  end
end
