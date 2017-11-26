class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :load_project, only: %i(show create update update_status)
  before_action :check_permission, only: %i(update create)
  def create
    # params[:task][:user_id] = current_user.id
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
    render json: {
      task: render_to_string(partial: "tasks/modal_task", locals: {task: @task, project: @project})
    }
  end

  def update
    @task = @project.tasks.find_by id: params[:id]
    if @task
      if params[:task][:name].present?
        @task.update_attributes name: params[:task][:name]

        render json: {
          task: @task
        }
      end

      if params[:task][:description].present?
        @task.update_attributes description: params[:task][:description]

        render json: {
          task: @task
        }
      end

      if params[:task][:status].present?
        status = Status.find_by name: params[:task][:status]
        @task.update_attributes status_id: status.id
        @task.activities.create activity_type: "status", content: "update", 
          activity_id: @task.id, user_id: current_user.id
        render json: {
          task: @task,
          list_activities: render_to_string(partial: "activities/list_activities", 
            locals: {activities: @task.activities}),
        }
      end

      if params[:task][:user_id].present?
        if params[:task][:checked] == "checked"
          @task.update_attributes user_id: params[:task][:user_id]
        else
          @task.update_attributes user_id: nil
        end
        @task.activities.create activity_type: "assignee", content: "update", 
          activity_id: @task.id, user_id: current_user.id
        render json: {
          task: @task,
          list_activities: render_to_string(partial: "activities/list_activities", 
            locals: {activities: @task.activities}),
          user: render_to_string(partial: "users/assignee_item_task", locals: {user: @task.user})
        }
      end

      if params[:task][:deadline].present?
        @task.update_attributes deadline: params[:task][:deadline]
        @task.activities.create activity_type: "deadline", content: "update", 
          activity_id: @task.id, user_id: current_user.id
        render json: {
          task: @task,
          due_date_info: render_to_string(partial: "tasks/due_date_modal", locals: {task: @task}),
          due_date_task: render_to_string(partial: "tasks/due_date_task", locals: {task: @task})
        }
      end
    end
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

    @task.activities.create activity_type: "label", content: "update", 
      activity_id: @task.id, user_id: current_user.id

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
    params.require(:task).permit :name, :status_id, :user_id, :description
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
