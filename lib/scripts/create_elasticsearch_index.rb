require 'faraday'

elasticsearch_url = ENV['SEARCHBOX_SSL_URL'] || ENV['ELASTICSEARCH_URL'] || 'http://localhost:9200'
Faraday.put("#{elasticsearch_url}/language-analyzer-service-index")
