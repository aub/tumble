require 'spec_helper'

describe Tumble::Config do
  it 'should allow me to set the consumer key and secret' do
    Tumble.config do |config|
      config.consumer_key = 'abc'
      config.consumer_secret = '123'
    end
    Tumble::Config.consumer_key.should == 'abc'
    Tumble::Config.consumer_secret.should == '123'
  end
end

