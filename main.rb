require 'sinatra'
require 'cassandra/0.7'
require 'erb'
include SimpleUUID


before do 
  @tracker = Cassandra.new("Tracker")
end

get "/" do
  erb :demo
end

get "/page" do
  "This is another page"
end

get "/report/:api_key/:ad_id/:session_id/:event_type" do
  # 
  # client = tracker.get(:Clients, params[:api_key])
  # unless client.empty? or params[:event_type].empty?
    # save the event
    @tracker.insert :TrackedEvents, params[:ad_id]+"/"+params[:event_type], { params[:session_id] => {"timestamp" => Time.now.to_s} }    
  # end
end

get "/reports" do 
  
  # get all ads
  @ads = @tracker.get_range :TrackedEvents, {}
  
  erb :reports
end

get "/reports/:ad_id" do
  @ad = @tracker.get_range( :TrackedEvents, {:start => params[:ad_id]+'/'}) #the trailing slash here is important. without it cassandra won't return for some reason.
  erb :report
end

