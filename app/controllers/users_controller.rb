class UsersController < ApplicationController
  before_action :find_user, only: %i(update show)

  def index
    @users = User.where("name LIKE '%#{params[:key_word]}%'").limit 5
    render json: {list_user: render_to_string(partial: "users/user", collection: @users)}
  end
  
  def show; end

  def edit; end

  def update_avatar

  end

  def update
    if @user.update_attributes params_user
      flash[:success] = "Update success!"
      redirect_to @user
    else
      flash[:error] = "Update no success!"
      redirect_to root_url
    end
  end

  private

  def params_user
    params.require(:user).permit :avatar, :name, :password, :email, :password_confirmation
  end

  def find_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless @user
  end
end
