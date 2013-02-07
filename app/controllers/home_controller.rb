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
    puts doc.xpath('/feed/entry/content').length.to_s + "total elements"
    doc.xpath('/feed/entry/content').each do |x|
        @rows << x.children()[0].content().split(',').collect{|d| d.split(':')[1]}
    end

    render layout: "no_nav"
  end

end
