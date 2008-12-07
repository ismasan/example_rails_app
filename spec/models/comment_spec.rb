require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Comment do
  before(:each) do
    @published_post = Post.create do |p|
      p.title         = 'some post'
      p.publish_at    = 1.day.ago
      p.unpublish_at  = 2.days.from_now
    end
    
    @unpublished_post = Post.create do |p|
      p.title         = 'some other post'
      p.publish_at    = 1.day.from_now
      p.unpublish_at  = 2.days.from_now
    end
    
    @published_comment_in_published_post = @published_post.comments.create do |c|
      c.body         = 'some comment'
      c.publish_at    = 1.day.ago
      c.unpublish_at  = 2.days.from_now
    end
    
    @published_comment_in_unpublished_post = @unpublished_post.comments.create do |c|
      c.body         = 'some other comment'
      c.publish_at    = 1.day.ago
      c.unpublish_at  = 2.days.from_now
    end
    
    @unpublished_comment_in_published_post = @published_post.comments.create do |c|
      c.body         = 'some other comment 2'
      c.publish_at    = 1.day.from_now
      c.unpublish_at  = 2.days.from_now
    end
    
    @unupublished_comment_in_unpublished_post = @unpublished_post.comments.create do |c|
      c.body         = 'some other comment 3'
      c.publish_at    = 1.day.from_now
      c.unpublish_at  = 2.days.from_now
    end
    
  end
  
  it "should find published comment at class level" do
    Comment.published.size.should == 2
  end
  
  it "should find published comments in collection" do
    @published_post.comments.published.size.should == 1
  end
  
  it "should find published comments in a collection with conditions" do
    @published_post.published_comments.size.should == 1
  end
  
  it "should work with named scope at class level" do
    Comment.published.size.should == 2
  end
  
  it "should work with named scope at collection level" do
    @published_post.comments.published.size.should == 1
  end
  
  it "should find unpublished with named scope" do
    Comment.unpublished.size.should == 2
    @published_post.comments.unpublished.size.should == 1
  end
  
  it "should find all with conditional flag" do
    Comment.published_only.size.should == 2
    Comment.published_only(true).size.should == 2
    @published_post.comments.published_only(true).first.should == @published_comment_in_published_post
    @published_post.comments.published_only(false).first.should == @unpublished_comment_in_published_post
  end
end
