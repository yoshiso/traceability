require 'sinatra'
require 'json'

get "/json" do
  content_type :json
  {
    status: :ok,
    response: "test response"
  }.to_json
end

post "/json" do
  content_type :json
  {
    status: :ok,
    response: "test response"
  }.to_json
end

get "/html" do
  content_type :html
  {
    status: :ok,
    response: "test response"
  }.to_json
end