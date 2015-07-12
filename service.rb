require 'json'
require 'sinatra'
require 'faraday'

[:get, :post].each do |type|
  send type, '/analyze' do
    elasticsearch_url = ENV['SEARCHBOX_SSL_URL'] || ENV['ELASTICSEARCH_URL'] || 'http://localhost:9200'

    connection = Faraday.new(url: "#{elasticsearch_url}/language-analyzer-service-index/_analyze")

    response = connection.get do |req|
      req.options.timeout = 5
      req.body = params['text']
    end

    content_type :json
    status response.status
    response.body
  end
end
