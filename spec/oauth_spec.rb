require 'spec_helper'

describe Tumble::Request::TumblrOAuth do
  let(:oauth) { Tumble::Request::TumblrOAuth.new(lambda{ |env| env }, Hash.new) }
  let(:request) do
    {
      :method => 'post', 
      :url => 'http://test.com/test.json', 
      :request_headers => {}, 
      :body => { :status => 'Test' }
    }
  end

  it 'should sign requests correctly' do
    response = SimpleOAuth::Header.parse(oauth.call(request)[:request_headers]['Authorization'])
    signature = response.delete(:signature)
    header = SimpleOAuth::Header.new(:post, "http://test.com/test.json", { :status => 'Test' }, response)
    signature.should == SimpleOAuth::Header.parse(header.to_s)[:signature]
  end
end
