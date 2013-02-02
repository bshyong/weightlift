class UsersController < ApplicationController
  # signs user in or redirect
  # https://github.com/plataformatec/devise/wiki/How-To:-Use-Devise-generated-method-and-filters-for-controllers
  before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

end
