module Tumble
  class Blog
    def initialize(connection, name)
      @connection = connection
      @name = name
    end

    attr_reader :name

    # This method returns general information about the blog, such as the title, 
    # number of posts, and other high-level data.
    #
    # @see http://www.tumblr.com/docs/en/api/v2#blog-info
    # @requires_authentication Yes
    def info
      @connection.get("/blog/#{name}/info").response
    end

    # You can get a blog's avatar in 9 different sizes. The default size is 64x64.
    #
    # @see http://www.tumblr.com/docs/en/api/v2#blog-avatar
    # @requires_authentication No
    #
    # @param options [Hash] A customizable set of options.
    # @option options [Integer] :size The size of the avatar. Must be in 16, 24, 30, 40, 48, 64, 96, 128, or 512
    def avatar(options={})
      @connection.get("/blog/#{name}/avatar", options).response
    end

    # Retrieve a Blog's Followers
    #
    # @see http://www.tumblr.com/docs/en/api/v2#blog-followers
    # @requires_authentication Yes
    #
    # @param options [Hash] A customizable set of options.
    # @option options [Integer] :limit The number of results to return: 1–20, inclusive
    # @option options [Integer] :offset Result to start at
    def followers(options={})
      @connection.get("/blog/#{name}/followers", options).response
    end

    # Retrieve Published Posts
    #
    # @see http://www.tumblr.com/docs/en/api/v2#posts
    # @requires_authentication Yes
    #
    # @param options [Hash] A customizable set of options.
    # @option options [String] :type The type of post to return. Specify one of the following:  text, quote, link, answer, video, audio, photo
    # @option options [Integer] :id A specific post ID. Returns the single post specified or (if not found) a 404 error.
    # @option options [String] :tag Limits the response to posts with the specified tag
    # @option options [Integer] :limit The number of posts to return: 1–20, inclusive
    # @option options [Integer] :offset Post number to start at
    # @option options [Boolean] :reblog_info Indicates whether to return reblog information (specify true or false). Returns the various reblogged_ fields.
    # @option options [Boolean] :notes_info Indicates whether to return notes information (specify true or false). Returns note count and note metadata.
    # @option options [String] :format Specifies the post format to return, other than HTML. Must be either text or raw.
    def posts(options={})
      @connection.get("/blog/#{name}/posts", options).response
    end

    # Retrieve Queued Posts
    #
    # @see http://www.tumblr.com/docs/en/api/v2#blog-queue
    # @requires_authentication Yes
    def queue
      @connection.get("/blog/#{name}/posts/queue").response
    end

    # Retreive Draft Posts
    #
    # @see http://www.tumblr.com/docs/en/api/v2#blog-drafts
    # @requires_authentication Yes
    def drafts
      @connection.get("/blog/#{name}/posts/draft").response
    end

    # Retreive Submission Posts
    #
    # @see http://www.tumblr.com/docs/en/api/v2#blog-submissions
    # @requires_authentication Yes
    def submissions
      @connection.get("/blog/#{name}/posts/submission").response
    end

    # Create a New Blog Post
    #
    # @see http://www.tumblr.com/docs/en/api/v2#posting
    # @requires_authentication Yes
    #
    # @param options [Hash] A customizable set of options
    # @option options [String] :type The type of post to create. Specify one of the following:  text, photo, quote, link, chat, audio, video
    # @option options [String] :state The state of the post. Specify one of the following:  published, draft, queue
    # @option options [String] :tags Comma-separated tags for this post
    # @option options [String] :tweet Manages the autotweet (if enabled) for this post: set to off for no tweet, or enter text to override the default tweet
    # @option options [String] :date The GMT date and time of the post, as a string
    # @option options [Boolean] :markdown Indicates whether the post uses markdown syntax
    # @option options [String] :slug Add a short text summary to the end of the post URL
    # For text posts:
    # @option options [String] :title The optional title of the post, HTML entities must be escaped
    # @option options [String] :body The full post body, HTML allowed
    # For photo posts:
    # @option options [String] :caption The user-supplied caption, HTML allowed
    # @option options [String] :link The "click-through URL" for the photo
    # @option options [String] :source The photo source URL
    # @option options [Array] :data One or more image files (submit multiple times to create a slide show)
    # For quote posts:
    # @option options [String] :quote The full text of the quote, HTML entities must be escaped
    # @option options [String] :source Cited source, HTML allowed
    # For link posts:
    # @option options [String] :title The title of the page the link points to, HTML entities should be escaped
    # @option options [String] :url The link
    # @option options [String] :description A user-supplied description, HTML allowed
    # For chat posts:
    # @option options [String] :title The title of the chat
    # @option options [String] :conversation The text of the conversation/chat, with dialogue labels (no HTML)
    # For audio posts:
    # @option options [String] :caption The user-supplied caption
    # @option options [String] :external_url The URL of the site that hosts the audio file (not tumblr)
    # @option options [String] :data An audio file
    # For video posts:
    # @option options [String] :caption The user-supplied caption
    # @option options [String] :embed HTML embed code for the video
    # @option options [String] :data A video file
    def create_post(options={})
      @connection.post("/blog/#{name}/post", options).response
    end

    # Edit a Blog Post
    #
    # @see http://www.tumblr.com/docs/en/api/v2#editing
    # @requires_authentication Yes
    #
    # @param id [Integer] The ID of the post to edit
    # @param options [Hash] A customizable set of options
    # @option options [String] :type The type of post to create. Specify one of the following:  text, photo, quote, link, chat, audio, video
    # @option options [String] :state The state of the post. Specify one of the following:  published, draft, queue
    # @option options [String] :tags Comma-separated tags for this post
    # @option options [String] :tweet Manages the autotweet (if enabled) for this post: set to off for no tweet, or enter text to override the default tweet
    # @option options [String] :date The GMT date and time of the post, as a string
    # @option options [Boolean] :markdown Indicates whether the post uses markdown syntax
    # @option options [String] :slug Add a short text summary to the end of the post URL
    # For text posts:
    # @option options [String] :title The optional title of the post, HTML entities must be escaped
    # @option options [String] :body The full post body, HTML allowed
    # For photo posts:
    # @option options [String] :caption The user-supplied caption, HTML allowed
    # @option options [String] :link The "click-through URL" for the photo
    # @option options [String] :source The photo source URL
    # @option options [Array] :data One or more image files (submit multiple times to create a slide show)
    # For quote posts:
    # @option options [String] :quote The full text of the quote, HTML entities must be escaped
    # @option options [String] :source Cited source, HTML allowed
    # For link posts:
    # @option options [String] :title The title of the page the link points to, HTML entities should be escaped
    # @option options [String] :url The link
    # @option options [String] :description A user-supplied description, HTML allowed
    # For chat posts:
    # @option options [String] :title The title of the chat
    # @option options [String] :conversation The text of the conversation/chat, with dialogue labels (no HTML)
    # For audio posts:
    # @option options [String] :caption The user-supplied caption
    # @option options [String] :external_url The URL of the site that hosts the audio file (not tumblr)
    # @option options [String] :data An audio file
    # For video posts:
    # @option options [String] :caption The user-supplied caption
    # @option options [String] :embed HTML embed code for the video
    # @option options [String] :data A video file

    def edit_post(id, options={})
      @connection.post("/blog/#{name}/post/edit", options.merge('id' => id)).response
    end

    # Reblog a Post
    #
    # @see http://www.tumblr.com/docs/en/api/v2#reblogging
    # @requires_authentication Yes
    #
    # @param id [Integer] The ID of the reblogged post on tumblelog
    # @param reblog_key [Integer] The reblog key for the reblogged post – get the reblog key with a /posts request
    # @param options [Hash] A customizable set of options
    # @option options [String] :comment A comment added to the reblogged post
    def reblog_post(id, reblog_key, options={})
      @connection.post("/blog/#{name}/post/reblog", options.merge('id' => id, 'reblog_key' => reblog_key)).response
    end

    # Delete a Post
    #
    # @see http://www.tumblr.com/docs/en/api/v2#deleting-posts
    # @requires_authentication Yes
    #
    # @param id [Integer] The ID of the post to delete
    def delete_post(id)
      @connection.post("/blog/#{name}/post/delete", :id => id).response
    end
  end
end
