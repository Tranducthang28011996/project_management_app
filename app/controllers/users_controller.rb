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
    @user.update_attributes params_user

    if @user.save
      flash[:success] = "Update success!"
      redirect_to root_url
    else
      flash[:error] = "Update no success!"
      redirect_to @user
    end
  end

  private

  def params_user
    params.require(:user).permit :name, :password, :email, :password_confirmation
  end

  def find_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless @user
  end
end
