require 'spec_helper'

describe Post do

  before :all do
    @post = build(:post, title: nil, content: '<h1>Some Title</h1><p>some text <strong>again</strong></p>')
  end

  it 'should return shortened post content if excerpt is nil' do
    @post.post_excerpt.should == 'Some Title some text again...'
  end

  it 'should not have a slug if title is nil and post is not saved' do
    @post.slug.should == nil
  end

  it 'should have a slug after setting title and saving' do
    @post.title = 'Some Test Title'
    @post.save
    @post.slug.should == 'some-test-title'
  end

  it 'should get post id from its uid' do
    @post.id.should == Post.id_from_uid(@post.uid)
  end
end
