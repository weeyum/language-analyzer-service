require 'rubygems'
require 'bundler/setup'
require './service'
require 'rack/contrib/post_body_content_type_parser'

set :run, false
set :raise_errors, true
disable :protection

use Rack::PostBodyContentTypeParser
run Sinatra::Application
