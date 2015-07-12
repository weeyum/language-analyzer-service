## Description
Given an input string, it will return a list of tokens after performing the following transformations:

1. [tokenize](https://www.elastic.co/guide/en/elasticsearch/reference/1.6/analysis-tokenizers.html)
2. filter [stopwords](https://en.wikipedia.org/wiki/Stop_words)
3. [stem](https://en.wikipedia.org/wiki/Stemming)

The API also allows an optional `locale` parameter to specify which analyzer to use.

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

## Setup (start Elasticsearch process first)
```
git clone https://github.com/weeyum/language-analyzer-service.git
cd language-analyzer-service
bundle install
rake
rackup
```

## API Specification
[GET /analyze](#get-analyze)<br>
[POST /analyze](#post-analyze)<br>

#### GET /analyze

parameters:
* locale `String`
* text `String`

supported locales:
```js
["ar", "hy", "eu", "pt-br", "bg", "ca", "zh", "cs", "da", "nl", "en", "fi", "fr", "gl", "de", "hi", "hu", "id", "ga", "it", "ja", "ko", "ku", "no", "fa", "pt-pt", "ro", "ru", "es", "sv", "tr", "th"]
```

_example:_
```
curl https://language-analyzer-service.herokuapp.com/analyze?text=this%20is%20hello%20world.
```

_response:_
```js
{
    "tokens": [
        {
            "token": "hello",
            "start_offset": 8,
            "end_offset": 13,
            "type": "<ALPHANUM>",
            "position": 3
        },
        {
            "token": "world",
            "start_offset": 14,
            "end_offset": 19,
            "type": "<ALPHANUM>",
            "position": 4
        }
    ]
}
```

#### POST /analyze

parameters:
* locale `String`
* text `String`

supported locales:
```js
["ar", "hy", "eu", "pt-br", "bg", "ca", "zh", "cs", "da", "nl", "en", "fi", "fr", "gl", "de", "hi", "hu", "id", "ga", "it", "ja", "ko", "ku", "no", "fa", "pt-pt", "ro", "ru", "es", "sv", "tr", "th"]
```

_example:_
```
curl -X POST https://language-analyzer-service.herokuapp.com/analyze \
  --header "Content-Type:application/json" \
  --data '{"locale": "en", "text": "this is hello world."}'
```

_response:_
```js
{
    "tokens": [
        {
            "token": "hello",
            "start_offset": 8,
            "end_offset": 13,
            "type": "<ALPHANUM>",
            "position": 3
        },
        {
            "token": "world",
            "start_offset": 14,
            "end_offset": 19,
            "type": "<ALPHANUM>",
            "position": 4
        }
    ]
}
```
