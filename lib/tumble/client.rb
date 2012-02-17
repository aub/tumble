require 'faraday'
require 'faraday_middleware'

module Tumble
  class Client

    # Initialize a client to use for making requests
    #
    # @param [String] oauth_token
    # @param [String] oauth_secret
    def initialize(access_token, access_secret)
      @access_token = access_token
      @access_secret = access_secret
    end
    
    def connection
      options = {
        :url => api_url,
        :params => { :oauth_token => @oauth_token },
        :headers => {
          :accept =>  'application/json',
          :user_agent => 'tumble'
        }
      }
      @connection ||= Faraday::Connection.new(options) do |builder|
        builder.use Faraday::Request::Multipart
        builder.use Faraday::Request::UrlEncoded
        builder.use FaradayMiddleware::Mashify
        builder.use FaradayMiddleware::ParseJson
        builder.use Tumble::Request::TumblrOAuth, credentials
        builder.adapter Faraday.default_adapter
      end
    end

    def api_url
      'http://api.tumblr.com/v2'
    end

    def blog(blog_name)
      Blog.new(self, blog_name)
    end

    def credentials
      {
        :consumer_key => Config.consumer_key,
        :consumer_secret => Config.consumer_secret,
        :token => @access_token,
        :token_secret => @access_secret,
      }
    end

    def user_info
      @connection.post('http://api.tumblr.com/v2/user/info')
    end
  end
end
