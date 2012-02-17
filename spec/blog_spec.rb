require 'spec_helper'

describe Tumble::Blog do
  let(:client) { Tumble::Client.new('token') }
  let(:blog) { client.blog('testy') }

  it 'should give me its name' do
    blog.name.should == 'testy'
  end

  it 'should give me info about the blog' do
    blog.info.should == 'ack'
  end
end
