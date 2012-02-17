require 'faraday'
require 'simple_oauth'

module Tumble
  module Request
    class TumblrOAuth < Faraday::Middleware

      def call(env)
        params = env[:body].is_a?(Hash) ? env[:body] : {}
        signature_params = params.reject{ |k,v| v.respond_to?(:content_type) }
        header = SimpleOAuth::Header.new(env[:method], env[:url], signature_params, @options)
        env[:request_headers]['Authorization'] = header.to_s
        @app.call(env)
      end

      def initialize(app, options)
        @app = app
        @options = options
      end
    end
  end
end
