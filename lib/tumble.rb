%w(blog client).each do |file|
  require File.join(File.dirname(__FILE__), 'tumble', file)
end

module Tumble
  VERSION = '0.0.2'
end
