require 'spec_helper'

describe Post do

  before(:all) do
    @post = Post.new(:excerpt => 'test', :content => 'some text')
    @post.author_id = 10
  end

  it 'should not have a slug if title is nil and post is not saved' do
    @post.slug.should == nil
  end

  it 'should have a slug after setting title and saving' do
    @post.title = 'Some Test Title'
    @post.save
    @post.slug.should == 'some-test-title'
  end

end
