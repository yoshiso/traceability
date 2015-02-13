module Traceability

  module Models

    class Configuration

      attr_accessor :store
      attr_accessor :store_file_path
      attr_accessor :max_history_size
      attr_accessor :request_filter

      def initialize
        @store = :file
        @store_file_path = "tmp/traceability"
        @max_history_size = 30
        @request_filter = lambda { |uri, resposne_header| resposne_header["Content-Type"] == "application/json" }
      end

    end

  end

end