class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => [:track]

  def index
    if signed_in?
        @user = current_user
        @reps = current_user.reps.recent.limit(5)
    end
  end

  def track
    if params[:name].blank? || params[:count].blank? || params[:weight].blank?
      flash.now[:alert] = "Something went wrong!  Please try again."
      @user = current_user
      @reps = current_user.reps.recent.limit(5)
      render 'index' and return
    end
    lift = Lift.find_or_create_by(name: params[:name])
    current_user.reps << lift.reps.create(count: params[:count], weight: params[:weight])
    redirect_to :root
  end

  def temp_home
    require 'open-uri'
    require 'nokogiri'
    url = "https://spreadsheets.google.com/feeds/list/0AhERslPRRahKdFl6UFZoQTh2UVdXLXBPTDlVS1dqanc/od6/public/basic"
    doc = Nokogiri::XML(open(url))
    doc.remove_namespaces!
    @rows = []
    @total_weight = 0
    puts doc.xpath('/feed/entry/content').length.to_s + "total elements"
    doc.xpath('/feed/entry/content').each do |x|
        content = x.children()[0].content().split(',').collect{|d| d.split(':')[1].strip}
        @rows << (content << content[1].to_i*content[2].to_i)
        @total_weight += content[1].to_i*content[2].to_i
        puts @total_weight
    end

    render layout: "no_nav"
  end

end
