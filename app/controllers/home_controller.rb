class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => [:track]

  autocomplete :lift, :name, :full => true, :display_value => :capitalized_name

  include ActionView::Helpers::JavaScriptHelper

  def index
    if signed_in?
        @user = current_user
        @reps = current_user.reps.recent.limit(5)
    end
  end

  def track
    begin
      @user = current_user
      @reps = current_user.reps.recent.limit(5)
      name = params[:name]
      raise "Name cannot be blank!" if name.blank?
      count = Integer(params[:count])
      weight = Integer(params[:weight])
    rescue
      flash.now[:alert] = "Something went wrong!  Please try again."
      render 'index' and return
    end
    lift = Lift.find_or_create_by(name: name)
    rep = lift.reps.create(count: count, weight: weight)
    current_user.reps << rep
    @script = "<script>function repeatLift(){$('#name').val('#{escape_javascript(name)}');$('#count').val(#{count.to_json});$('#weight').val(#{weight.to_json});}</script>"
    flash[:success] = "Success! #{rep.count} reps of #{lift.name} @ #{rep.weight} lbs each for a total of #{rep.total_weight} lbs. [<a href='#' onclick='repeatLift();'>Repeat</a>]".html_safe
    render 'index'
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
