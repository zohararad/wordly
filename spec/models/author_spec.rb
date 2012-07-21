require 'spec_helper'

describe Author do

  before(:all) do
    @author = Author.new(:email => 'author@example.com', :password => '1234567890')
  end

  it 'should have an empty full_name if first_name and last_name are nil' do
    @author.full_name.should == ''
  end

  it 'should have a full_name if first_name and last_name are set' do
    @author.first_name = 'John'
    @author.last_name = 'Doe'
    @author.full_name.should == 'John Doe'
  end

  it 'should not have a slug before saving' do
    @author.slug.should == nil
  end

  it 'should have a slug after saving' do
    @author.save
    @author.slug.should == 'john-doe'
  end

end
