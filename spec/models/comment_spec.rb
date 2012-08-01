require 'spec_helper'

describe Comment do

  before :each do
    @post = create(:post)
    @post.save

    @comment = build(:comment)
    @comment.post = @post
  end

  it 'should increment comment count when creating a new comment' do
    @comment.save
    @post.comment_count.should == 1
  end

  it 'should decrement comment count when creating a new comment' do
    @comment.save
    previous_count = @post.comment_count
    @comment.destroy
    @post.comment_count.should == previous_count - 1
  end

  it 'should create comment hierarchy when replying to a comment' do
    @comment.save
    reply_to_comment = build(:comment)
    reply_to_comment.post = @post
    reply_to_comment.comment_parent_id = @comment.id
    reply_to_comment.save
    reply_to_comment.hierarchy.should == '%s-%s' % [@comment.hierarchy, @comment.id]
  end
end
