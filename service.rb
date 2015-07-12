require 'json'
require 'sinatra'
require 'faraday'

# https://www.elastic.co/guide/en/elasticsearch/guide/current/language-intro.html
LOCALES = {"ar"=>"arabic", "hy"=>"armenian", "eu"=>"basque", "pt-br"=>"brazilian", "bg"=>"bulgarian", "ca"=>"catalan", "zh"=>"chinese", "cs"=>"czech", "da"=>"danish", "nl"=>"dutch", "en"=>"english", "fi"=>"finnish", "fr"=>"french", "gl"=>"galician", "de"=>"german", "hi"=>"hindi", "hu"=>"hungarian", "id"=>"indonesian", "ga"=>"irish", "it"=>"italian", "ja"=>"cjk", "ko"=>"cjk", "ku"=>"latvian", "no"=>"norwegian", "fa"=>"persian", "pt-pt"=>"portuguese", "ro"=>"romanian", "ru"=>"russian", "es"=>"spanish", "sv"=>"swedish", "tr"=>"turkish", "th"=>"thai"}

[:get, :post].each do |type|
  send type, '/analyze' do
    elasticsearch_url = ENV['SEARCHBOX_SSL_URL'] || ENV['ELASTICSEARCH_URL'] || 'http://localhost:9200'

    return status 422 if params[:text].length <= 0

    analyzer = LOCALES[params[:locale]] || 'english'

    response = Faraday.new(url: "#{elasticsearch_url}/language-analyzer-service-index/_analyze?analyzer=#{analyzer}").get do |req|
      req.options.timeout = 5
      req.body = params['text']
    end

    content_type :json
    status response.status
    response.body
  end
end
