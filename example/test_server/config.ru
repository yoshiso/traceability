require 'rack'
require 'sinatra'

require File.expand_path 'main', File.dirname(__FILE__)

require File.expand_path '../../lib/traceability/middleware', File.dirname(__FILE__)

use Traceability::Middleware

run Sinatra::Application