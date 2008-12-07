require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Post do
  before(:each) do
    @published = Post.create do |p|
      p.title         = 'some post'
      p.publish_at    = 1.day.ago
      p.unpublish_at  = 2.days.from_now
    end
    
    @unpublished = Post.create do |p|
      p.title         = 'some other post'
      p.publish_at    = 1.day.from_now
      p.unpublish_at  = 2.days.from_now
    end
  end

  it "should be valid" do
    @published.should be_valid
    @unpublished.should be_valid
  end
  
  it "should find published one" do
    @published.published?.should be_true
    Post.published.size.should == 1
  end
end
