class HomeController < ApplicationController

  def index
    @users = User.all
  end

  def temp_home
    render layout: "no_nav"
  end

end
