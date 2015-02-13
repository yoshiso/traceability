require 'json'
require 'pry'

module Traceability
  # This is not a public API
  module WebHelpers

    def root_path
      "#{env['SCRIPT_NAME']}/"
    end

    def current_path
      @current_path ||= request.path_info.gsub(/^\//,'')
    end

    def active uid
      current_path.include?(uid) ? "active" : ""
    end

    def pretty_json json
      if json.class == String
        tmp = JSON.parse(json)
      else
        tmp = json
      end
      pretty_json =  JSON.pretty_generate(tmp)
      pretty_json
    rescue => e
      "no json"
    end

    def environment_title_prefix
      environment =  ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'development'

      "[#{environment.upcase}] " unless environment == "production"
    end

    def product_version
      "Traceability v#{Traceability::VERSION}"
    end
  end
end