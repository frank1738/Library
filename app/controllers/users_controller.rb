class UsersController < ApplicationController

  def index

    @users = User.all

  end



  def destroy

    @user = User.find(params[:id])
    authorize! :destroy,@user

    @user.destroy

    redirect_to users_path, notice: 'User was successfully deleted.'

  end

end

