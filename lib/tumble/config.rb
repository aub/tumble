module Tumble
  module Config
    def self.consumer_key=(key)
      @consumer_key = key
    end

    def self.consumer_key
      @consumer_key
    end

    def self.consumer_secret=(secret)
      @consumer_secret = secret
    end

    def self.consumer_secret
      @consumer_secret
    end
  end
end
