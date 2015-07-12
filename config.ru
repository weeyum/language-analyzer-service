require 'rubygems'
require 'bundler/setup'
require './service'

set :run, false
set :raise_errors, true
disable :protection

run Sinatra::Application
