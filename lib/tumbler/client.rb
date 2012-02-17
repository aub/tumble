require 'faraday'
require 'faraday_middleware'

module Tumble
  class Client

    # Initialize a client to use for making requests
    #
    # @param [String] oauth_token
    # @param [Hash] options
    # @option options Hash   :ssl Additional SSL options (like the path to certificate file)
    def initialize(oauth_token, options={})
      @oauth_token = options[:oauth_token]
      @ssl = options[:ssl].nil? ? Hash.new : options[:ssl]
    end
    
    def ssl
      @ssl
    end
    
    def connection
      options = {
        :url => api_url,
        :ssl => @ssl,
        :params => { :oauth_token => @oauth_token },
        :headers => default_headers
      }
      @connection ||= Faraday::Connection.new(options) do |builder|
        builder.use Faraday::Request::Multipart
        builder.use Faraday::Request::UrlEncoded
        builder.use FaradayMiddleware::Mashify
        builder.use FaradayMiddleware::ParseJson
        builder.adapter Faraday.default_adapter
      end
    end

    def api_url
      'http://api.tumblr.com/v2'
    end

    def blog(blog_name)
      Blog.new(self, blog_name)
    end

    private

    def default_headers
      headers = {
        :accept =>  'application/json',
        :user_agent => 'tumble'
      }
    end
  end
end
