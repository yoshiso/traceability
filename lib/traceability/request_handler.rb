require 'traceability/models/request'
require 'traceability/models/request_environment'
require 'traceability/models/response'

module Traceability

  class RequestHandler

    def initialize app, env
      @app = app
      @env = Traceability::Models::RequestEnvironment.new env
    end

    def run

      @response = Traceability::Models::Response.new @app.call(@env.to_rack_env)

      match_target do
        trace_request
      end

      self
    end

    def to_response
      @response.to_rack_response
    end

    private

      def match_target &block

        if Traceability.configuration.request_filter.call(@env.request_uri, @response.header)
          yield if block_given?
        end

      end

      def trace_request
        Traceability::Request.create({
          url:@env.request_uri,
          method: @env.request_method,
          status: @response.status,
          query_params: @env.query_params,
          form_params: @env.form_params,
          response_header: @response.header,
          response_body: @response.body,
        })
        Traceability::Request.ensure_max_size
      end

  end

end