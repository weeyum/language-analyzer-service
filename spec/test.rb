ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/rg'
require 'rack/test'
require_relative '../service.rb'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "Service" do
  let(:text) { 'test' }
  let(:locale) { 'en' }

  [:get, :post].each do |type|
    LOCALES.each do |locale, analyzer|
      describe "#{type} request with locale=#{locale}" do
        subject { send type, "/analyze?locale=#{locale}&text=#{text}" }

        it "should return json" do
          subject
          last_response.headers['Content-Type'].must_equal 'application/json'
        end

        it "should return the correct tokens" do
          subject
          JSON.parse(last_response.body)['tokens'].length.must_equal 1
        end
      end
    end
  end
end
