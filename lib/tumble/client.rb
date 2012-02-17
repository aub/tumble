require 'faraday'
require 'faraday_middleware'

module Tumble
  class Client

    # Initialize a client to use for making requests
    #
    # @param [String] oauth_token
    # @param [String] oauth_secret
    def initialize(access_token, access_secret)
      @connection = Connection.new(access_token, access_secret)
    end
    
    def blog(name)
      Blog.new(@connection, name)
    end

    # Get Info for the Authenticated User
    #
    # @see http://www.tumblr.com/docs/en/api/v2#user-methods
    # @requires_authentication Yes
    def user_info
      @connection.post('/user/info').body.response.user
    end

    # Retrieve a User's Dashboard
    #
    # @see http://www.tumblr.com/docs/en/api/v2#user-methods
    # @requires_authentication Yes
    # 
    # @param options [Hash] A customizable set of options.
    # @option options [Integer] :limit The number of results to return: 1–20, inclusive
    # @option options [Integer] :offset Post number to start at
    # @option options [String] :type The type of post to return. Specify one of the following:  text, photo, quote, link, chat, audio, video, question
    # @option options [Integer] :since_id Return posts that have appeared after this ID
    # @option options [Boolean] :reblog_info Indicates whether to return reblog information (specify true or false). Returns the various reblogged_ fields.
    # @option options [Boolean] :notes_info Indicates whether to return notes information (specify true or false). Returns note count and note metadata.
    def dashboard(options={})
      @connection.get('/user/dashboard')
    end

    # Retrieve a User's Likes
    #
    # @see http://www.tumblr.com/docs/en/api/v2#user-methods
    # @requires_authentication Yes
    # 
    # @param options [Hash] A customizable set of options.
    # @option options [Integer] :limit The number of results to return: 1–20, inclusive
    # @option options [Integer] :offset Post number to start at
    def likes(options={})
      @connection.get('/user/likes')
    end

    # Retrieve the Blogs a User Is Following
    #
    # @see http://www.tumblr.com/docs/en/api/v2#user-methods
    # @requires_authentication Yes
    # 
    # @param options [Hash] A customizable set of options.
    # @option options [Integer] :limit The number of results to return: 1–20, inclusive
    # @option options [Integer] :offset Post number to start at
    def following(options={})
      @connection.get('/user/following')
    end

    # Follow a Blog
    #
    # @see http://www.tumblr.com/docs/en/api/v2#user-methods
    # @requires_authentication Yes
    # 
    # @param url [String] The URL of the blog to follow
    def follow(url)
      @connection.post('/user/follow', :url => url)
    end

    # Unfollow a Blog
    #
    # @see http://www.tumblr.com/docs/en/api/v2#user-methods
    # @requires_authentication Yes
    # 
    # @param url [String] The URL of the blog to follow
    def unfollow(url)
      @connection.post('/user/unfollow', :url => url)
    end

    # Like a Post
    #
    # @see http://www.tumblr.com/docs/en/api/v2#user-methods
    # @requires_authentication Yes
    # 
    # @param id [Integer] The ID of the post to like
    # @param reblog_key [String] The reblog key for the post id
    def like(id, reblog_key)
      @connection.post('/user/like', :id => id, :reblog_key => reblog_key) 
    end

    # Unlike a Post
    #
    # @see http://www.tumblr.com/docs/en/api/v2#user-methods
    # @requires_authentication Yes
    # 
    # @param id [Integer] The ID of the post to unlike
    # @param reblog_key [String] The reblog key for the post id
    def unlike(id, reblog_key)
      @connection.post('/user/unlike', :id => id, :reblog_key => reblog_key) 
    end
  end
end
