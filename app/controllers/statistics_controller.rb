class StatisticsController < ApplicationController

  def index
    @projects = Project.load_project current_user.id
    @status_task = {
      New: @projects.first.tasks.where(status_id: 1).size,
      Processing: @projects.first.tasks.where(status_id: 2).size,
      Resolved: @projects.first.tasks.where(status_id: 3).size,
      Testing: @projects.first.tasks.where(status_id: 4).size,
      Done: @projects.first.tasks.where(status_id: 5).size
    }
  end

  def create
    if request.xhr?
      @project = Project.find_by id: params[:statistic][:project_id]

      if @project.statistic.nil?
        @statistic = Statistic.create statistic_params
        @project.statistic = @statistic
        statistic_stattus = "new_record"
      else
        @project.statistic.update_attributes statistic_params
      end

      @status_task = {
        New: @project.tasks.where(status_id: 1).size,
        Processing: @project.tasks.where(status_id: 2).size,
        Resolved: @project.tasks.where(status_id: 3).size,
        Testing: @project.tasks.where(status_id: 4).size,
        Done: @project.tasks.where(status_id: 5).size
      }

      render json: {
        html: render_to_string(partial: 'statistics/chart',
          locals: {status_task: @status_task, project: @project}),
          statistic_stattus: statistic_stattus
      }
    end
  end

  private

  def statistic_params
    params.require(:statistic).permit :chart_type
  end
end
