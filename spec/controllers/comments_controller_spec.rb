require 'spec_helper'

describe CommentsController do

  def stub_warden
    request.env['warden'] = mock(Warden, :authenticate => nil, :authenticate! => nil, :authenticate? => nil)
  end

  def do_create
    stub_warden
    post :create, :comment => @comment.attributes.merge({:uid => @post.uid_from_id})
  end

  context 'when posting a valid comment' do
    before :each do
      @post = FactoryGirl.create(:post, :slug => 'some-slug')
      @comment = FactoryGirl.build(:comment)
      Post.should_receive(:find).and_return(@post)
      Comment.should_receive(:new).and_return(@comment)
    end

    it "should successfully save the comment" do
      @comment.should_receive(:save).and_return(true)
      do_create
    end

    it 'should have "successfully saved" in flash[:notice]' do
      do_create
      flash[:notice].should match(/successfully\ssaved/i)
    end

    it 'should redirect to post url after saving comment' do
      do_create
      response.should redirect_to(post_path(@post.slug))
    end
  end

  context 'when posting an invalid comment' do

    before :each do
      @post = FactoryGirl.create(:post, :slug => 'some-slug')
      @comment = FactoryGirl.build(:comment,:author_name => nil, :author_email => nil)
      Post.should_receive(:find).and_return(@post)
      Comment.should_receive(:new).and_return(@comment)
    end

    it "should not save the comment" do
      @comment.should_receive(:save).and_return(false)
      do_create
    end

    it 'should have "successfully saved" in flash[:notice]' do
      do_create
      flash[:error].should match(/not\ssaved/i)
    end

    it 'should render posts/show when failing to save comment' do
      do_create
      response.should render_template("posts/show")
    end
  end

end
