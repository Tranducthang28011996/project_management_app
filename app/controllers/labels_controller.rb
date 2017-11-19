class LabelsController < ApplicationController
	before_filter :find_model

	def update
		
	end

	private
	def find_model
		
		@label = Labels.find_by id: params[:id]
		redirect_to root_url unless @label
	end
end