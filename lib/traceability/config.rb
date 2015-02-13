require 'traceability/models/configuration'

module Traceability

  module Config


    def configure
      yield configuration if block_given?
    end

    def configuration
      @configuration ||= Traceability::Models::Configuration.new
    end

  end

  extend Config

end