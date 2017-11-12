class TeamsController < ApplicationController
	before_action :load_team

	def update
		@user = User.find_by id: params[:user]
		if @user
			@team.add_member @user
			render json: {status: :success}
		else
			render json: {status: :fail}
		end
	end

	private

	def load_team
		@team = Team.find_by id: params[:id]

		return if @team
		redirect_to root_url	
	end

	def find_model
		@model = Teams.find(params[:id]) if params[:id]
	end
end