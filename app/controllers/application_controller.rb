class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  # before_action :load_language
  include ApplicationHelper

  def after_sign_in_path_for(resource)
  	# session[:language] = :vi if session[:language].nil?
    if current_user.admin?
      rails_admin_url
    else
      root_url
    end
  end

  # private

  # def load_language
  # 	if session[:language]
	 #  	I18n.locale = session[:language]
		# else
		# 	I18n.locale = :en
  # 	end
  # end
end
