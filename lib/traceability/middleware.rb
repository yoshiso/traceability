require 'traceability'
require 'traceability/request_handler'

module Traceability

  class Middleware

    def initialize(app)
      @app = app
    end

    def call(env)
      RequestHandler.new(@app, env).run.to_response
    end

  end

end