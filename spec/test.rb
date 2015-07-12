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
  let(:text) { 'hello' }

  [:get, :post].each do |type|
    describe "#{type}" do
      subject { send type, "/analyze?text=#{text}" }

      it "should return json" do
        subject
        last_response.headers['Content-Type'].must_equal 'application/json'
      end

      it "should return the correct tokens" do
        subject
        last_response.body.must_match text
      end
    end
  end
end
