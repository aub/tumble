%w(blog client config connection request/oauth).each do |file|
  require File.join(File.dirname(__FILE__), 'tumble', file)
end

module Tumble
  VERSION = '0.0.8'

  def self.configure
    yield Config
    Config
  end
end
