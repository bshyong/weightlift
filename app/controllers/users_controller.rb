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
      @user = User.where(username_slug: params[:id]).first
    ensure
      redirect_to :root and return if @user.blank?
      @reps = @user.reps.recent
      @total_weight = @user.reps.sum(:total_weight)
      # @lifts = @user.reps.map(&:lift).map(&:name).occurence_count.sort{|a,b| b[1] <=> a[1]}
      @lifts = @user.top_lifts_by_rep_count(4)
    end
  end

end
