module Tumble
  class Connection

    def initialize(token, secret)
      @token = token
      @secret = secret
    end

    def base_url
      'http://api.tumblr.com/'
    end

    def delete(path, params={})
      request(:delete, path, params)
    end

    # Perform an HTTP GET request
    def get(path, params={})
      request(:get, path, params)
    end

    # Perform an HTTP POST request
    def post(path, params={})
      request(:post, path, params)
    end

    private

    def request(method, path, params)
      path = "/v2#{path}" unless path =~ /^\/v2/
      response = faraday_connection.send(method) do |request|
        case method
        when :delete, :get
          request.url(path, params)
        when :post
          request.path = path
          request.body = params unless params.empty?
        end
      end
      response.body
    end

    def faraday_connection
      options = {
        :url => base_url,
        :headers => {
          :accept =>  'application/json',
          :user_agent => 'tumble'
        },
        :params => { :api_key => credentials[:consumer_key] }
      }
      @faraday_connection ||= Faraday::Connection.new(options) do |builder|
        builder.use Faraday::Request::UrlEncoded
        builder.use Faraday::Request::Multipart
        builder.use FaradayMiddleware::Mashify
        builder.use FaradayMiddleware::ParseJson
        builder.use Tumble::Request::TumblrOAuth, credentials
        builder.adapter Faraday.default_adapter
      end
    end

    def credentials
      {
        :consumer_key => Config.consumer_key,
        :consumer_secret => Config.consumer_secret,
        :token => @token,
        :token_secret => @secret,
      }
    end
  end
end
