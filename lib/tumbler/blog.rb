module Tumble
  class Blog
    def initialize(client, name)
      @client = client
      @name = name
    end

    attr_reader :name

    def info
      @client.connection.get("blog/#{name}/info")
    end
  end
end
