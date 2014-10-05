require 'sinatra'
require 'open-uri'
require 'json'

BASE_URL = "http://mahouka.jp/img/special/message/mahouka_msg"
MAX_ONISAMA = 17

get '/' do
  erb :index
end

get '/api' do
  id = get_random_id

  get_json(create_url(id), id)
end

get '/api/:id' do |id|
  id = validate(id)

  get_json(create_url(id), id)
end

def get_random_id
  id = rand(MAX_ONISAMA) + 1
end

def validate(id)
  id = 1 if id.to_i < 1 or id.to_i > MAX_ONISAMA
  id
end

def create_url(id)
  url = BASE_URL + sprintf("%02d", id) + ".jpg"
end

def get_json(url, id)
  content_type :json
  { :url => url, :id => id }.to_json
end
