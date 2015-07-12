require 'faraday'

elasticsearch_url = ENV['SEARCHBOX_SSL_URL'] || ENV['ELASTICSEARCH_URL'] || 'http://localhost:9200'
uri = URI.parse(elasticsearch_url)
conn = Faraday.new("#{elasticsearch_url}")
conn.basic_auth(uri.user, uri.password)
conn.put('/language-analyzer-service-index')
