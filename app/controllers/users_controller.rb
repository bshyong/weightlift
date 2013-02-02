class UsersController < ApplicationController
  # signs user in or redirect
  before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

end
