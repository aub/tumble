require 'spec_helper'

describe Tumble::Connection do
  let(:connection) { Tumble::Connection.new('abc', '123') }

  it 'should perform a get request' do
    stub = WebMock.stub_request(:get, /http:\/\/api\.tumblr\.com\/v2\/user\/info?.*/)
    connection.get('/user/info')
    stub.should have_been_requested
  end

  it 'should perform a post request' do
    stub = WebMock.stub_request(:post, /http:\/\/api\.tumblr\.com\/v2\/user\/info?.*/)
    connection.post('/user/info')
    stub.should have_been_requested
  end
end
