require 'json'
require "sinatra/base"

require "traceability/models/request"
require "traceability/web_helper"

module Traceability

  class Web < Sinatra::Base

    set :root, File.expand_path(File.dirname(__FILE__) + "/../../web")
    set :public_folder, Proc.new { "#{root}/assets" }
    set :views, Proc.new { "#{root}/views" }

    helpers WebHelpers

    get "/" do
      @traceability_request = Traceability::Request.last
      erb :requests
    end

    get "/request/:uid" do
      @traceability_request = Traceability::Request.find_by(uid: params[:uid])
      erb :request
    end

  end

end