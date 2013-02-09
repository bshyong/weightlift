class HomeController < ApplicationController

  def index
    @users = User.all
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
