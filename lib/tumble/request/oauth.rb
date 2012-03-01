require 'faraday'

module Tumble
  module Request

    class TumblrOAuth < Faraday::Middleware
      dependency 'simple_oauth'

      AUTH_HEADER = 'Authorization'.freeze

      def initialize(app, options)
        super(app)
        @options = options
      end

      def call(env)
        env[:request_headers][AUTH_HEADER] ||= oauth_header(env).to_s if sign_request?(env)
        @app.call(env)
      end

      def oauth_header(env)
        SimpleOAuth::Header.new env[:method],
                                env[:url].to_s,
                                signature_params(body_params(env)),
                                oauth_options(env)
      end

      def sign_request?(env)
        !!env[:request].fetch(:oauth, true)
      end

      def oauth_options(env)
        if extra = env[:request][:oauth] and extra.is_a? Hash and !extra.empty?
          @options.merge extra
        else
          @options
        end
      end

      def body_params(env)
        env[:body] || {}
      end

      def signature_params(params)
        params.empty? ? params :
          params.reject {|k,v| v.respond_to?(:content_type) }
      end
    end
  end
end
