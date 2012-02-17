require 'spec_helper'

describe Tumble::Client do
  it 'should return a connection' do
    Tumble::Client.new('token').connection.should be_an_instance_of(Faraday::Connection)
  end

  it 'should return a blog' do
    blog = Tumble::Client.new('token').blog('testy')
    blog.should be_an_instance_of(Tumble::Blog)
    blog.name.should == 'testy'
  end
end
