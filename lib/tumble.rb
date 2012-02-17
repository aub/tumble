%w(blog client config request/oauth).each do |file|
  require File.join(File.dirname(__FILE__), 'tumble', file)
end

module Tumble
  VERSION = '0.0.3'

  def self.config
    yield Config
    Config
  end
end
