class UsersController < ApplicationController
  # signs user in or redirect
  # https://github.com/plataformatec/devise/wiki/How-To:-Use-Devise-generated-method-and-filters-for-controllers
  before_filter :authenticate_user!, :except => [:show]

  def index
    @users = User.all
  end

  def show
    begin
      @user = User.find(params[:id])
    rescue
      @user.where(:name)
    ensure

    end

    @reps = @user.reps.recent
  end

end
