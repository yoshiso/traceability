require 'traceability/models/base'
module Traceability

  module Models

    class Request < Base



      [:url, :status, :method, :form_params, :query_params, :response_header, :response_body].each do |m|
        define_accessor m
      end

      def hash_key
        "#{created_at} #{url}"
      end

      class << self
        def ensure_max_size
          while self.size > Traceability.configuration.max_history_size
            self.first.destroy
          end
        end
      end
    end

  end

end