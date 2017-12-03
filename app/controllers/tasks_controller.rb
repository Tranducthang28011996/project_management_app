class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :load_project, only: %i(show create update update_status)
  before_action :check_permission, only: %i(update create)
  def create
    params[:task][:creator_id] = current_user.id

    begin
    	@task = @project.tasks.create! task_params
      render json: {
        status: true,
        task:render_to_string(partial: "tasks/item_task", locals: {task: @task})
      }
    rescue => detail
      render json: {
        status: false,
        message: detail
      }
    end
  end

  def show
    @task = @project.tasks.includes(:status).find_by id: params[:id]
    @member = @project.get_member
     @activities = @task.activities.order('created_at DESC')
    render json: {
      task: render_to_string(partial: "tasks/modal_task", locals: {task: @task, project: @project})
    }
  end

  def update
    @task = @project.tasks.find_by id: params[:id]
    params[:task][:updator_id] = current_user.id

    @render_response = {}

    if params[:task][:status].present?
      status = Status.find_by name: params[:task][:status]
      params[:task][:status_id] = status.id if status
    end

    if @task && @task.update_attributes(task_params)
      if params[:task][:user_id].present? && params[:task][:user_id] != @task.user_id
        @render_response.merge! user: render_to_string(
            partial: "users/assignee_item_task",
            locals: {user: @task.user})
      elsif params[:task][:deadline].present?
        @render_response.merge! due_date_info: render_to_string(
                                  partial: "tasks/due_date_modal",
                                  locals: {task: @task}),
                                due_date_task: render_to_string(
                                  partial: "tasks/due_date_task",
                                  locals: {task: @task})
      end
    end

    @render_response.merge! task: @task

    render json: @render_response
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
      },
      list_activities: render_to_string(partial: "activities/list_activities",
        locals: {activities: @task.activities})
    }
  end

  private

  def load_project
  	@project = Project.find_by id: params[:project_id]
  	return if @project
  	redirect_to root_url
  end

  def task_params
    params.require(:task).permit :name, :status_id, :user_id, :description,
      :creator_id, :updator_id, :deadline
  end

  def check_permission
    return if @project.get_member.pluck(:id).include? current_user.id
    format_error_js
  end

  def format_error_js
    render json: {
      status: false
    }
  end
end
