require 'sinatra'
require 'rubygems'
require 'aws-record'


require_relative "models/landpage_lead.rb"
require_relative "models/contact_message.rb"
require_relative "controllers/landpage_lead_controller.rb"
require_relative "controllers/contact_message_controller.rb"


before do
  if (! request.body.read.empty? and request.body.size > 0)
    request.body.rewind
    @params = Sinatra::IndifferentHash.new
    @params.merge!(JSON.parse(request.body.read))
  end
end

##################################
# For the index page
##################################
get '/' do
  erb :index
end

get '/landpage' do
  erb :landpage
end


##################################
# Routes API
##################################

get '/api/lead' do
  content_type :json
  items = LandpageLeadController.list
end

post '/api/lead' do
  content_type :json
  item = LandpageLeadController.create(params)
  item.to_h.to_json
end


get '/api/contact_messages' do
  content_type :json
  items = ContactMessageController.list
end

post '/api/contact_messages' do
  content_type :json
  item = ContactMessageController.create(params)
  item.to_h.to_json
end

get '/api/contact_messages/:id' do
  # params.inspect
  content_type :json
  item = ContactMessageController.find_by_id( params["id"] )
end

get '/api/contact_messages/get_by_email/:email'  do
   content_type :json
   items = ContactMessageController.find_by_email(params['email'])
end
