class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  include ApplicationHelper
  
  def after_sign_in_path_for(resource)
    root_url
  end
end
