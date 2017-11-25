class SearchController < ApplicationController
  def index
    @keyword = params[:keyword]

    if @keyword
      @projects = current_user.projects.search @keyword
      @tasks = current_user.tasks.search @keyword

      render json: {
        status: true,
        html: render_to_string(partial: "search/result", layout: false)
      }
    end
  end
end
