module Traceability
  module Models
    class RequestEnvironment

      def initialize rack_env
        @rack_env = rack_env
      end

      def to_rack_env
        @rack_env
      end

      def request_method
        @rack_env["REQUEST_METHOD"]
      end

      def request_uri
        @rack_env["REQUEST_URI"]
      end

      def query_params
        @rack_env["rack.request.query_hash"]
      end

      def form_params
        @rack_env["rack.request.form_hash"]
      end

    end
  end
end