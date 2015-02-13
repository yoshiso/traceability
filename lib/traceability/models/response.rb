module Traceability

  module Models

    class Response

      def initialize rack_response
        @rack_response = rack_response
      end

      def to_rack_response
        @rack_response
      end

      def header
        @rack_response[1].to_hash
      end

      def body
        body_content = ""
        @rack_response[2].each do |part|
          body_content += part
        end
        body_content
      end

      def status
        @rack_response[0]
      end

    end

  end

end