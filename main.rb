require 'rubygems'
require 'sinatra'
require 'cassandra'
require 'erb'
include SimpleUUID


before do 
  @tracker = Cassandra.new("Tracker")
end

get "/" do
  erb :demo
end

get "/report/:api_key/:ad_id/:session_id/:event_type" do

  puts params[:api_key]
  client = @tracker.get( :Clients, params[:api_key])
  # unless client.empty? or params[:event_type].empty?
    # calculated metric id
    metric_id =  params[:ad_id]+"/"+params[:event_type]
    
    # create ad->metric map
    @tracker.insert( :Ads, params[:ad_id], {'clients' => {'client_id' => params[:api_key]}, 'metrics'=>{ metric_id => params[:event_type]}})
    
    # save the event
    @tracker.insert( :TrackedEvents, metric_id, { params[:session_id] => {"timestamp" => Time.now.to_s, UUID.new.to_guid=>params[:payload]} }    )
  # end
end

get "/reports" do 
  
  # get all ads
  @ads = @tracker.get_range( :Ads, {} )
  
  erb :reports
end

get "/reports/:ad_id" do
  @ad = @tracker.get(:Ads, params[:ad_id])
  
  # @ad = @tracker.get_range( :TrackedEvents, {:start => params[:ad_id]+'/'}) #the trailing slash here is important. without it cassandra won't return for some reason.
  erb :report
end


# ===API DOC===
# 
# /api/:apikey/client/:client_id
#   -- ret json client information
#   
# /api/:apikey/client/new (post)
#   -- ret true/false 
# 
# api/:apikey/client/:client_id/ad/:ad_id
#   -- ret json ad summery 
#   
# api/:apikey/client/:client_id/ad/:ad_id/:event
#   -- ret json ad/event summery

# create a client and return success status
post "/api/:apikey/client/new" do
  
end

# get client details and return them as json
get "/api/:apikey/client/:client_id" do 

end

# get details about an ad's summery and report that as json
get "/api/:apikey/client/:client_id/ad/:ad_id" do
  
end

# get details about an ad's event and report back as json
get "/api/:apikey/client/:client_id/ad/:ad_id/:event" do
  
end